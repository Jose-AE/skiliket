//
//  CreatePostViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 23/09/24.
//

import UIKit
import CoreLocation


class CreatePostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    let categories = ["Temperature", "Humidity", "Pressure", "Water Sensor", "Sound Sensor", "Other"]
    var pickerView = UIPickerView()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        categoryTextField.placeholder = "Select category"
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: true)
        categoryTextField.inputAccessoryView = toolbar

        setupLocationManager()
    }
    
    // Método del botón "Done" para cerrar el UIPickerView
       @objc func doneTapped() {
           categoryTextField.resignFirstResponder() // Ocultar el UIPickerView
       }
    
    // MARK: - Configuración de CLLocationManager
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
                if let placemark = placemarks?.first {
                    self.locationTextField.text = placemark.locality
                }
            }
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }

       // MARK: - UIPickerViewDataSource

       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return categories.count
       }

       // MARK: - UIPickerViewDelegate

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return categories[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           // Asignar la categoría seleccionada al UITextField
           categoryTextField.text = categories[row]
       }
    // MARK: - Funcionalidad para selección de imagen
    @IBAction func addImageTapped(_ sender: UIButton) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // Puedes cambiar a .camera si deseas usar la cámara
            imagePicker.allowsEditing = true // Permitir al usuario editar la imagen seleccionada
            present(imagePicker, animated: true, completion: nil)
        }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            postImageView.image = selectedImage // Asigna la imagen editada al UIImageView
        } else if let selectedImage = info[.originalImage] as? UIImage {
            postImageView.image = selectedImage // Asigna la imagen original al UIImageView
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil) 
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
