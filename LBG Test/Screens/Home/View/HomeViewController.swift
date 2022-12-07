//
//  ViewController.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewArt: UITableView!
    
    private var viewModel = HomeViewModel(_myArtResult: MyArtResult())
    private var cancellables: Set<AnyCancellable> = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewArt.register(UINib(nibName: "\(ArtTableCell.self)", bundle: nil), forCellReuseIdentifier: "\(ArtTableCell.self)")
        self.setupBinding()
        self.viewModel.fetchArts()
    }
    
    private func setupBinding() {
        self.viewModel.myArtResult.$arrayArts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableViewArt.reloadData()
            }
            .store(in: &cancellables)
        
        self.viewModel.myArtResult.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let _ = error {
                    self?.tableViewArt.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _error = self.viewModel.myArtResult.error {
            self.tableViewArt.setEmptyView(title: _error.localizedDescription, message: nil, enableRetry: true) {
                self.viewModel.fetchArts()
            }
        }
        else if (self.viewModel.myArtResult.arrayArts == nil) {
            self.tableViewArt.setIndicator()
        }
        else if (self.viewModel.myArtResult.arrayArts?.count ?? 0) == 0 {
            self.tableViewArt.setEmptyView(title: "No records available!", message: nil, enableRetry: true) {
                self.viewModel.fetchArts()
            }
        }
        else {
            self.tableViewArt.restore()
        }
        return self.viewModel.myArtResult.arrayArts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArtTableCell.self)") as? ArtTableCell else { return UITableViewCell() }
        cell.artInfo = self.viewModel.myArtResult.arrayArts?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let lastItem = (self.viewModel.myArtResult.arrayArts?.count ?? 0) - 5
        if indexPath.row == lastItem && !(self.viewModel.myArtResult.isCompleted)  {
            self.viewModel.myArtResult.page += 1
            self.viewModel.fetchArts()
        }
    }
}

