//
//  MapViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 13/10/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configura el delegado del MapView
        mapView.delegate = self
        
        // Coordenadas de las ciudades
        let cdmxCoordinates = CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332) // CDMX
        let gdlCoordinates = CLLocationCoordinate2D(latitude: 20.6597, longitude: -103.3496) // Guadalajara
        let torontoCoordinates = CLLocationCoordinate2D(latitude: 43.65107, longitude: -79.347015) // Toronto
        let mtyCoordinates = CLLocationCoordinate2D(latitude: 25.6866, longitude: -100.3161) // Monterrey
        
        // Anotaciones para las ciudades
        let cdmxAnnotation = MKPointAnnotation()
        cdmxAnnotation.coordinate = cdmxCoordinates
        cdmxAnnotation.title = "Ciudad de México"

        let gdlAnnotation = MKPointAnnotation()
        gdlAnnotation.coordinate = gdlCoordinates
        gdlAnnotation.title = "Guadalajara"

        let torontoAnnotation = MKPointAnnotation()
        torontoAnnotation.coordinate = torontoCoordinates
        torontoAnnotation.title = "Toronto"

        let mtyAnnotation = MKPointAnnotation()
        mtyAnnotation.coordinate = mtyCoordinates
        mtyAnnotation.title = "Monterrey"
        
        // Agregar las anotaciones al mapa
        mapView.addAnnotations([cdmxAnnotation, gdlAnnotation, torontoAnnotation, mtyAnnotation])
        
        // Configurar la región del mapa para mostrar todas las ciudades
        let region = MKCoordinateRegion(center: cdmxCoordinates, latitudinalMeters: 3000000, longitudinalMeters: 3000000)
        mapView.setRegion(region, animated: true)
    }
    
    // Personalización de las anotaciones (pines)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cityPin")
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cityPin")
            annotationView?.canShowCallout = true // Mostrar información del pin al hacer clic
        } else {
            annotationView?.annotation = annotation
        }

        // Personalizar el pin
        if let markerAnnotationView = annotationView as? MKMarkerAnnotationView {
            markerAnnotationView.markerTintColor = UIColor.purple // Cambiar el color del pin
        }

        return annotationView
    }

    /*
    // MARK: - Navigation
    // En un storyboard-based application, a menudo necesitarás preparar para la navegación.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Obtener el nuevo ViewController usando segue.destination.
        // Pasar el objeto seleccionado al nuevo ViewController.
    }
    */
}
