//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 28.04.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

//protocol FollowerListVCDelegate: class {
//    func didRequestFollowers(for username: String)
//}

class FollowerListVC: UIViewController {

    enum Section {
        case main
    }

    var username: String!
    var followers: [Follower] = [] // empty array
    var filteredFollowers: [Follower] = [] // for search
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureSearchController()
        configireCollectionView()
        getFollowers(username: username, page: page)
        configureDataSourse()

    }

    // MARK: - Configure UI

    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        
        print("Add button has tapped")
        
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else {return}
            self.dismissloadingActivityIndicator()
            
            switch result {
                
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.update(favorite: favorite, actiontype: .add) { [weak self](error) in
                    guard let self = self else {return}
                    guard let error = error else {
                        self.presentCustomAlertOnMaimThread(title: "Success!", message: "You have successfully favorited this user", buttonTitle: "Ok")
                        
                        return
                    }
                    
                    self.presentCustomAlertOnMaimThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentCustomAlertOnMaimThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
        print("Add button tapped")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

    // MARK: - Configure UICollection view in UIViewcintroller

    func configireCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIhelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

    // MARK: - Configure Cell

    func configureDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in

            // choose collectionview from local
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell

            cell.setFollower(follower: follower)

            return cell
        })
    }

    func getFollowers(username: String, page: Int) {
        // hendle patential memory leak [weak self] - capture list
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self](result) in
            guard let self = self else {return} // hendle patential memory leak
            self.dismissloadingActivityIndicator()

                    switch result {
                    case .success(let followers):
                        if followers.count < 100 {self.hasMoreFollowers = false}
                        self.followers.append(contentsOf: followers)

                        if self.followers.isEmpty {
                            let message = "This user doesn't have any followers. Go follow them 😀"
                            DispatchQueue.main.async {self.showEmptyStateView(with: message, in: self.view)}
                            return
                        }

                        self.updateData(on: self.followers)

                        //print(followers)
                    case .failure(let error):
                        self.presentCustomAlertOnMaimThread(title: "Bad Stuff Heppend", message: error.rawValue, buttonTitle: "Cancel")
                    }
                }
    }

    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true, completion: nil) }
    }

    // MARK: - Search

    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username..."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

// MARK: - Pagination

extension FollowerListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

//        print("offsetY = \(offsetY)")
//        print("contentHeight = \(contentHeight)")
//        print("height = \(height)")

        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers // What ? True : False
        let follower = activeArray[indexPath.item]

        let destVC = UserinfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true, completion: nil)
    }

}

// MARK: - Search Extantion

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        isSearching = true

        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFollowers)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //print("Cancel Taped")
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC: UserinfoVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followerrs for that user
        
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}


        // the old way
//        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
//            guard let followers = followers else {
//                self.presentCustomAlertOnMaimThread(title: "Bad Stuff Heppend", message: errorMessage!.rawValue, buttonTitle: "Cancel")
//                return
//            }
//
//            print("Followers.count = \(followers.count)")
//            print(followers)
//        }
