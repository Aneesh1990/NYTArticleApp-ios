//
//  ArticleViewController.swift
//  NYTArticleApp
//
//  Created by Aneesh on 01/09/2021.
//

import Foundation
import UIKit

class ArticleViewController: BaseViewController {
    //MARK:- IBOutlet
    @IBOutlet var tableView: UITableView!
    //MARK:- Let & Var
    let refreshControl = UIRefreshControl()
    var currentPeriod:Periods?{
        didSet{
            getArticle(period:currentPeriod ?? .Day)
        }
    }
    lazy var viewModel = {
        ArticleViewModel()
    }()
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    //MARK:- Private Methods
    fileprivate func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.identifier)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getArticle(period:currentPeriod ?? .Day)
    }
    fileprivate func initViewModel() {
        viewModel.delegate = self
        // Get articles data
        currentPeriod = .Day
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    fileprivate func getArticle(period:Periods){
        viewModel.getArticles(period: period)
    }
    //MARK:- IBActions
    @IBAction func showPeriods(){
        let alert = UIAlertController(title: "Periods", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Periods.Day.rawValue.description, style: .default , handler:{ (UIAlertAction)in
            self.currentPeriod = .Day
        }))
        
        alert.addAction(UIAlertAction(title: Periods.Week.rawValue.description, style: .default , handler:{ (UIAlertAction)in
            self.currentPeriod = .Week
        }))
        
        alert.addAction(UIAlertAction(title: Periods.Month.rawValue.description, style: .default , handler:{ (UIAlertAction)in
            self.currentPeriod = .Month
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}


// MARK: - UITableViewDelegate

extension ArticleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ArticleDetailController.controllerFromStoryboard(.main)
        controller.article = viewModel.getCellViewModel(at: indexPath)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        /*For UITestcase**/
        cell.accessibilityIdentifier = "Cell_\(indexPath.row)"
        /*For UITestcase**/
        return cell
    }
}
