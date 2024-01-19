//
//  ViewController.swift
//  Server Driven UI
//
//  Created by Chionia Kotsalidou on 30/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    public var screenData: Screen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: String(describing: LabelView.self),
                                 bundle: Bundle(for: Self.self)), forCellReuseIdentifier: LabelView.reuseIdentifier)
        tableView.register(UINib(nibName: String(describing: CollectionView.self),
                                 bundle: Bundle(for: Self.self)), forCellReuseIdentifier: CollectionView.reuseIdentifier)
        tableView.register(UINib(nibName: String(describing: ImageCell.self),
                                 bundle: Bundle(for: Self.self)), forCellReuseIdentifier: ImageCell.reuseIdentifier)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenData?.screenElements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCell(int: indexPath.row)
    }
    
    
    private func getCell(int: Int) -> UIElementViewCell {
        
        guard let element = screenData?.screenElements[int] else {
            return UIElementViewCell()
        }
        
        switch element.type {
        case .label:
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: LabelView.reuseIdentifier)
                    as? LabelView
            else { return UIElementViewCell() }

            customCell.configure(textData: element.textData,
                                 backgroundColor: element.backgroundColor)
            return customCell
        case .image:
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseIdentifier)
                    as? ImageCell
            else { return UIElementViewCell() }
            
            let imageURL = URL(string: element.textData?.text ?? "")
            let data = try? Data(contentsOf: imageURL!)
            customCell.configure(image: (UIImage(data: data!) ?? UIImage(systemName: "calendar")) ?? UIImage())
            
            return customCell
        case .collection:
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: CollectionView.reuseIdentifier)
                    as? CollectionView
            else { return UIElementViewCell() }

            customCell.configure(elements: element.collectionData ?? [], isSmall: element.isSmall ?? false)
            return customCell
        }
    }
    
}

