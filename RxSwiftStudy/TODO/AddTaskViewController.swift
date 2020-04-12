//
//  AddTaskViewController.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/10.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySegControl: UISegmentedControl!
    @IBOutlet weak var taskTextField: UITextField!
    
    // 이거는 private(set)으로 하면 한줄로도 가능!
    private let taskSubject: PublishSubject<Task> = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegControl.selectedSegmentIndex),
            let title = taskTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
}


