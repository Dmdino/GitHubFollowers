//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 24.04.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    
    let logoImageView = UIImageView()
    let usernameTextfield = CustomTextfield()
    let callToActionButton = CustomButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {return !usernameTextfield.text!.isEmpty} // return false by default  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground // adopts to both to the ligt and black mode
        configureUIandButtons()
        createDissmissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // I did it here but not in ViewDidLoad coz if I would do that in viewDidLoad then when I go back from other screen the navbar is were showed again.
        //navigationController?.isNavigationBarHidden = true
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDissmissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        
        // check the username textfield is not empty
               guard isUsernameEntered else {
                   print("No username!")
                   presentCustomAlertOnMaimThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "OK") // cmd + ctrl + space for emoji
                   return
                   
               }
        
        let followersListVC = FollowerListVC()
        followersListVC.username = usernameTextfield.text
        followersListVC.title = usernameTextfield.text
        navigationController?.pushViewController(followersListVC, animated: true)
        usernameTextfield.text = ""
    }
    
    
    func configureUIandButtons() {
        
        view.addSubview(logoImageView)
        logoImageView.image = #imageLiteral(resourceName: "gh-logo")
        
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 80, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(usernameTextfield)
        usernameTextfield.delegate = self
        
        usernameTextfield.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
        
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(self.pushFollowerListVC), for: .touchUpInside)
        
        callToActionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 50, right: 50), size: .init(width: 0, height: 50))
        
        // another way to contraint the view
        
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
//            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImageView.heightAnchor.constraint(equalToConstant: 200),
//            logoImageView.widthAnchor.constraint(equalToConstant: 200)
//        ])
        
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tap return")
        
        pushFollowerListVC()
        
        return true
    }
}
