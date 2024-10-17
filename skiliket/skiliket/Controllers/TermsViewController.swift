//
//  TermsViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 17/10/24.
//

import UIKit

class TermsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTermsAndConditions()
        // Do any additional setup after loading the view.
    }
    func fetchTermsAndConditions() {
        guard let url = URL(string: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo10/TermsAndConditions.json") else {
            print("Invalid URL")
            return
        }
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Llamamos a una función para formatear la información
                    let formattedText = self.formatTermsAndConditions(json: json)
                    
                    DispatchQueue.main.async {
                        self.textView.text = formattedText
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func formatTermsAndConditions(json: [String: Any]) -> String {
        var formattedText = ""
        
        if let privacyPolicy = json["Privacy_Policy_SKILIKET"] as? [String: Any] {
            formattedText += "Privacy Policy SKILIKET\n\n"
            
            if let lastUpdated = privacyPolicy["Last_Updated"] as? String {
                formattedText += "Last Updated: \(lastUpdated)\n\n"
            }
            
            if let dataController = privacyPolicy["Data_Controller"] as? [String: Any] {
                formattedText += "Data Controller:\n"
                if let name = dataController["Name"] as? String {
                    formattedText += "- Name: \(name)\n"
                }
                if let description = dataController["Description"] as? String {
                    formattedText += "- Description: \(description)\n"
                }
                if let contact = dataController["Contact"] as? String {
                    formattedText += "- Contact: \(contact)\n"
                }
                if let addressMexico = dataController["Address_Mexico"] as? String {
                    formattedText += "- Address (Mexico): \(addressMexico)\n"
                }
                if let addressCanada = dataController["Address_Canada"] as? String {
                    formattedText += "- Address (Canada): \(addressCanada)\n\n"
                }
            }
            
            if let personalDataCollected = privacyPolicy["Personal_Data_Collected"] as? [String: Any] {
                formattedText += "Personal Data Collected:\n"
                if let identificationData = personalDataCollected["Identification_Data"] as? [String] {
                    formattedText += "- Identification Data: \(identificationData.joined(separator: ", "))\n"
                }
                if let authenticationData = personalDataCollected["Authentication_Data"] as? [String] {
                    formattedText += "- Authentication Data: \(authenticationData.joined(separator: ", "))\n"
                }
                if let locationData = personalDataCollected["Location_Data"] as? String {
                    formattedText += "- Location Data: \(locationData)\n"
                }
                if let technicalData = personalDataCollected["Technical_Data"] as? [String] {
                    formattedText += "- Technical Data: \(technicalData.joined(separator: ", "))\n\n"
                }
            }
            
            if let purposesOfDataProcessing = privacyPolicy["Purposes_of_Data_Processing"] as? [String: Any] {
                formattedText += "Purposes of Data Processing:\n"
                if let primaryPurposes = purposesOfDataProcessing["Primary_Purposes"] as? [String] {
                    formattedText += "- Primary Purposes: \(primaryPurposes.joined(separator: ", "))\n"
                }
                if let secondaryPurposes = purposesOfDataProcessing["Secondary_Purposes"] as? [String] {
                    formattedText += "- Secondary Purposes: \(secondaryPurposes.joined(separator: ", "))\n\n"
                }
            }
            
            // Agregar más secciones según el contenido del JSON...
        }
        
        return formattedText
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
