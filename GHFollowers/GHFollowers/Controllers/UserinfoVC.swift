//
//  UserinfoVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 19.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

//protocol UserInfoVCDelegate: class {
//    func didTapGitHubProfile(for user: User)
//    func didTapGetFollowers(for user: User)
//}

protocol UserinfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserinfoVC: UIViewController {
    
    // MARK: - Properties
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var username: String!
    let dateLabel = CustomBodyTitleLabel(textAligment: .center)
    
    weak var delegate: UserinfoVCDelegate!
    
    //var itemViews: [UIView] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handeleDone))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func handeleDone() {dismiss(animated: true, completion: nil)}
    
    // MARK: - Network Call / API
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) {[weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case.success(let user):
                //print(user)
                DispatchQueue.main.async {
                    self.configureUIelements(with: user)
                }
            case.failure(let error):
                self.presentCustomAlertOnMaimThread(title: "Somthing went wring", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIelements(with user: User) {
        
        let repoItemsVC = GFReapoItemVC(user: user)
        repoItemsVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFInfoHeaderVCViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemsVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    // MARK: - Configure layout
    
    func layoutUI() {
        
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
        let padding: CGFloat = 20
        
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 180))
        
        itemViewOne.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 180))
        //itemViewOne.backgroundColor = .systemPurple
        
        itemViewTwo.anchor(top: itemViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 180))
        //itemViewTwo.backgroundColor = .systemRed
        
        dateLabel.anchor(top: itemViewTwo.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: padding, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 18))
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserinfoVC: ItemInfoVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        // show safari view controller
        print("It's working")
        guard let url = URL(string: user.htmlUrl) else {
            presentCustomAlertOnMaimThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        
        presentSafariVC(with: url)
        
    }
    
    func didTapGetFollowers(for user: User) {
          // dismiss vc
          // tell follower list screen the new user
        guard user.followers != 0 else {
            presentCustomAlertOnMaimThread(title: "No followers", message: "This user has no followers 😔", buttonTitle: "So Sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        handeleDone()
      }
}
