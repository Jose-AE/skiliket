//
//  SingUpViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 17/09/24.
//

import UIKit

class SingUpViewController: UIViewController {
    @IBOutlet weak var singInButton: UIButton!
    
    @IBOutlet weak var checkboxButton: UIButton!
    var isChecked = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func checkboxButtonPressed(_ sender: Any) {
        if isChecked == false {
            checkboxButton.setImage(UIImage(named: "checkbox"), for: .normal)
            isChecked = true
        }else {
            checkboxButton.setImage(UIImage(named: "unchecked"), for: .normal)
            isChecked = false
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
