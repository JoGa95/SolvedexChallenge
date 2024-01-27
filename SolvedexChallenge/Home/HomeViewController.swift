//
//  HomeViewController.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var pugsCollectionView: UICollectionView!
    
    private let viewModel: HomeViewModelType
    private typealias Text = AppStrings.HomeScreen
    private var pugsArray: [SavedPugs] = []
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didChange = { [weak self] in
            self?.configure()
        }
        viewModel.start()
        setupCollectionView()
    }
    
    private func configure() {
        switch viewModel.state {
        case .idle:
            viewModel.getPugData(self)
        case .started(let pugsData):
            DispatchQueue.main.async {
                self.pugsArray = pugsData
                self.pugsCollectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        pugsCollectionView.register(UINib(nibName: "PugCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PugCell")
        pugsCollectionView.delegate = self
        pugsCollectionView.dataSource = self
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pugsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pugsCollectionView.dequeueReusableCell(withReuseIdentifier: "PugCell",
                                                                  for: indexPath) as? PugCollectionViewCell else {
            return UICollectionViewCell()
        }
        // We get index item to set values to cell
        let pugElement = pugsArray[indexPath.row]
        cell.likeCounterLabel.text = Text.likesLabel.rawValue.replacingOccurrences(of: "@", with: String(pugElement.likes))
        let url = URL(string: pugElement.image ?? "")!
        // Download image from URL through extension
        cell.pugImageView.downloaded(from: url)
        // Like button action
        cell.likeButtonAction = {
            self.viewModel.updatePug(imageURL: self.pugsArray[indexPath.row].image ?? "")
            self.pugsCollectionView.reloadItems(at: [indexPath])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == pugsArray.count - 1 ) { //it's your last cell
            self.viewModel.getPugData(self)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
}
