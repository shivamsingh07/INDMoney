//
//  ViewController.swift
//  Trial2
//
//  Created by ShivamSingh on 16/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var n = 0
    var row = 0
    var col = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.isHidden = true
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
       n = Int(textField.text!)!
        DispatchQueue.main.async {
            self.row = 0
            self.col = 0
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return n*n
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if (col > n-1) {
            row = row + 1
            col = 0
        }
        
        if (row == 0 || row == n-1) {
            cell.backgroundColor = .red
        } else if (col == 0 || col == n-1) {
            cell.backgroundColor = .red
        } else if ( row + col == n - 1 || row == col) {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .gray
        }
        col = col + 1
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 2.0, bottom: 1.0, right: 2.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / CGFloat(n) - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 2, height: 50)
    }
}
