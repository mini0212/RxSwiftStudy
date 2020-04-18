//
//  TodoListViewController.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/10.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 테이블뷰 컨트롤러를 사용하지 않는 이유
 테이블 뷰를 로드할 때 상단에 세그먼트를 사용해서 제어할 것이기 때문에!
*/
class TodoListViewController: UIViewController {

    @IBOutlet weak var prioritySegControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // 선생님이 나중에는 이걸로 바뀔수도 있다고했음! 선견지명
    private let tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
//        prioritySegControl.rx
//            .selectedSegmentIndex
//            .asObservable()
//            .subscribe(onNext: { index in
//            print(index)
//            }).disposed(by: disposeBag)
        Observable.combineLatest(
            prioritySegControl.rx.selectedSegmentIndex.asObservable(),
            tasks.asObservable())
            .subscribe(onNext: { [unowned self] index, task in
                let priority = Priority(rawValue: index - 1)
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController,
            let vc = navVC.viewControllers.first as? AddTaskViewController else {
                fatalError("Controller not Found")
        }
        
        vc.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
//                print(task)
                // Cannot use mutating member on immutable value: 'value' is a get-only property 라서 아래는 안됨
//                self.tasks.value.append(task)
                
                // 0번째는 all이기 때문에 -1씩 해준다
//                let priority = Priority(rawValue: self.prioritySegControl.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                
//                self.filterTasks(by: priority)
                
            }).disposed(by: disposeBag)
    }
    
    @IBAction func priorityValueChanged(_ segControl: UISegmentedControl) {
//        let priority = Priority(rawValue: segControl.selectedSegmentIndex - 1)
//        filterTasks(by: priority)
    }
}

extension TodoListViewController {
    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    /*
     왜 Priority가 옵셔널인가?
     Priority의 enum에는 high, medium, low 세가지이지만
     segment control에는 all까지 네 개가 있기 때문에 priority가 없으면 전체 리스트를 보여 줄 것!
     */
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter {
                    $0.priority == priority!
                }
            }.subscribe(onNext: { [weak self] tasks in
                guard let self = self else { return }
                self.filteredTasks = tasks
                self.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = filteredTasks[indexPath.row].title
        return cell
    }
}

extension TodoListViewController: UITableViewDelegate {
    
}
