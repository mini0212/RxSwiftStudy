//
//  NewsViewController.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/18.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 6ab77ef6d5de4aa0bea4b2124f56527b


class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        populateNews()
        // Do any additional setup after loading the view.
    }
}

extension NewsListViewController {
    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.largeTitleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func populateNews() {
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6ab77ef6d5de4aa0bea4b2124f56527b")!
//        let resource = Resource<ArticlesList>(url: url)
        
//        URLRequest.load(resource: resource)
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        
//        Observable.just(url)
//            .flatMap { url -> Observable<Data> in
//                let request = URLRequest(url: url)
//                return URLSession.shared.rx.data(request: request)
//        }.map { data -> [Article]? in
//            return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
//        }.subscribe(onNext: { [weak self] articles in
//            if let articles = articles {
//                self?.articles = articles
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            }
//        }).disposed(by: disposeBag)
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AritlcleTableViewCell", for: indexPath) as? AritlcleTableViewCell else {
            fatalError("AritlcleTableViewCell is not exist")
        }
        
        let item = articles[indexPath.row]
        cell.titleLbl.text = item.title
        cell.descriptionLbl.text = item.description
        
        return cell
    }
    
    
    
}

extension NewsListViewController: UITableViewDelegate {
    
}
