//
//  ViewController.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 11/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
        return tableView
    }()
    
    private var viewModels: [FeedViewModel] = []
    private var layouts: [FeedCellLayout] = []
    private let imageService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    
        DispatchQueue.global().async {
            var viewModels: [FeedViewModel] = []
            var layouts: [FeedCellLayout] = []
            for _ in 0..<1000 {
                let feed = Feed(
                    avatarImageURLString: "https://pp.userapi.com/c836526/v836526896/6686b/rLc_YmpuS1k.jpg",
                    name: "Some",
                    likesCount: 1000,
                    date: Date().addingTimeInterval(1000),
                    postText: randomString(Int(arc4random() % 60 + 500))
                )
                let viewModel = FeedViewModel(feed: feed)
                viewModels.append(viewModel)
                let layout = viewModel.layout(for: UIScreen.main.bounds.width)
                layouts.append(layout)
            }
            DispatchQueue.main.async {
                self.viewModels = viewModels
                self.layouts = layouts
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if tableView.frame != view.bounds {
            tableView.frame = view.bounds
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return layouts[indexPath.row].height
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        let viewModel = viewModels[indexPath.row]
        let layout = layouts[indexPath.row]
        cell.configure(
            viewModel: viewModels[indexPath.row], layout: layout
        )
        imageService.fetchImage(
            url: viewModel.avatarURL!,
            size: CGSize(width: 40, height: 40),
            onCompletion: cell.avatarImageCallback
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
