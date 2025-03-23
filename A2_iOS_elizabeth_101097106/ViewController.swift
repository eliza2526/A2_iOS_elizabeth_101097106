//
//  ViewController.swift
//  A2_iOS_elizabeth_101097106
//
//  Created by Elizabeth Thomas on 2025-03-23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
 
    
  
    var products: [Product] = []
    var currentIndex = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchProducts()
        if !products.isEmpty {
            displayProduct(at: 0)
        }
    }

    @IBAction func prevButtonTapped(_ sender: Any) {
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func displayProduct(at index: Int) {
        let product = products[index]
        nameLabel.text = product.name
        descriptionLabel.text = product.productDescription
        priceLabel.text = "Price: \(product.price)"
        providerLabel.text = "Provider: \(String(describing: product.provider))"
        
    }
    
}

