//
//  ViewController.swift
//  TakeHomeProject
//
//  Created by Jonathan Oh on 3/11/18.
//  Copyright © 2018 Jonathan Oh. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {

    let catTableView = UITableView()
    private var cats = [[Cat]]()
    private var isCurrentlyRequestingCats = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCatTableView()
        makeCatRequestForPage(cats.count)
    }
    
    func setupCatTableView() {
        catTableView.register(CatCell.self, forCellReuseIdentifier: CatCell.id)
        catTableView.dataSource = self
        catTableView.delegate = self
        view.addSubview(catTableView)
        catTableView.frame = view.frame
    }
    
    func makeCatRequestForPage(_ page: Int) {
        if isCurrentlyRequestingCats { return }
        print("Request Cat Page: \(page)")
        isCurrentlyRequestingCats = true
        let catRequest = CatRequest(pageNumber: page)
        catRequest.send { [weak self] (catResponse) in
            self?.cats.append(catResponse)
            DispatchQueue.main.async { [weak self] in
                self?.catTableView.reloadData()
                self?.isCurrentlyRequestingCats = false
            }
        }
    }
    
}

extension CatViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        let isCurrentlyAtBottomOfScrollView = distanceFromBottom < height
        if isCurrentlyAtBottomOfScrollView {
            makeCatRequestForPage(cats.count)
        }
    }
}
extension CatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatCell.id) as? CatCell else { return UITableViewCell() }
        let currentCat = cats[indexPath.section][indexPath.row]
        cell.setupViewsWithCat(currentCat)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cats.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

