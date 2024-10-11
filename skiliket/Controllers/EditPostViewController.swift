//
//  EditPostViewController.swift
//  skiliket
//
//  Created by Jesus Jionary Gutierrez Moreno on 11/10/24.
//

import UIKit

class EditPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
   
    @IBAction func saveButtonTapped(_ sender: Any) {
        // 1. Crear el UIAlertController
        let alertController = UIAlertController(title: "Confirm Changes?", message: "Are you sure you want to save the changes?", preferredStyle: .alert)
        
        // 2. Crear las acciones "Cancel" y "Accept"
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel tapped")
        }
        let acceptAction = UIAlertAction(title: "Accept", style: .default) { (action) in
            print("Accept tapped")
            // Aquí puedes añadir la lógica para guardar los cambios
        }
        
        // 3. Añadir las acciones al UIAlertController
        alertController.addAction(cancelAction)
        alertController.addAction(acceptAction)
        
        // 4. Mostrar la alerta
        self.present(alertController, animated: true, completion: nil)
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
