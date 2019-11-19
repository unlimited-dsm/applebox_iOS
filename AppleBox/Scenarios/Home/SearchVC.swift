//
//  SearchVC.swift
//  AppleBox
//
//  Created by leedonggi on 2019/11/18.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController, StoryboardView {
    
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSearchBar.layer.cornerRadius = viewSearchBar.frame.height / 2
        viewSearchBar.layer.borderWidth = 1
        viewSearchBar.layer.borderColor = UIColor(named: "MainPink")?.cgColor
    }
    
    func bind(reactor: SearchReactor) {
        txtSearchBar.rx.controlEvent([.editingChanged])
            .map{Reactor.Action.typing}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
