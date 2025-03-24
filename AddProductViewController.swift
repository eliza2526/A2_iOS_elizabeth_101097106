//
//  AddProductViewController.swift
//  A2_iOS_elizabeth_101097106
//
//  Created by Elizabeth Thomas on 2025-03-23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var providerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newProduct = Product(context: context)
        newProduct.productID = UUID().uuidString
        newProduct.name = nameTextField.text
        newProduct.productDescription = descriptionTextView.text
        newProduct.price = Double(priceTextField.text ?? "0") ?? 0
        newProduct.provider = providerTextField.text
        
        do {
            try context.save()
            print("Product Saved Successfully")
            //navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Error saving product: \(error)")
        }
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
