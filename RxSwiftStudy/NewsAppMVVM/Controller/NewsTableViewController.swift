//
//  NewsTableViewController.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/05/05.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var articleTableVM: ArticleTableViewModel!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
        populateNews()
    }
    
}

extension NewsTableViewController {
    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func populateNews() {
        let resource = NewsResource<MVVMArticleResponae>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6ab77ef6d5de4aa0bea4b2124f56527b")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] articleResponse in
                let article = articleResponse.articles
                self?.articleTableVM = ArticleTableViewModel(article)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}


extension NewsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleTableVM == nil ? 0 : articleTableVM.articleVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        let articleVM = self.articleTableVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
    
}

extension NewsTableViewController: UITableViewDelegate {

}
