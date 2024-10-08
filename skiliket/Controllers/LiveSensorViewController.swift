import UIKit
import SwiftUI

class LiveSensorViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!

    
    @IBOutlet weak var sensorButton1: UIButton!
    @IBOutlet weak var sensorButton2: UIButton!
    @IBOutlet weak var sensorButton3: UIButton!
    @IBOutlet weak var sensorButton4: UIButton!
    @IBOutlet weak var sensorButton5: UIButton!
    
    @IBOutlet weak var sensorTypeLabel: UILabel!
    @IBOutlet weak var sensorGraphView: UIView!
    
    let sensors = ["Temperature", "Humidity", "Atmospheric Pressure", "Water", "Sound/Noise"]
    var selectedSensor: String = "Temperature"
    var sensorData: [Double] = [20, 30, 25, 40, 35, 50]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateGraphForSensor(selectedSensor)
    }
    
    func setupUI() {
        liveLabel.layer.cornerRadius = 4
        liveLabel.clipsToBounds = true
        liveLabel.backgroundColor = .red
        liveLabel.textColor = .white
        
        sensorTypeLabel.text = selectedSensor
        sensorTypeLabel.textColor = UIColor.purple
        
        sensorButton1.setTitle(sensors[0], for: .normal)
        sensorButton2.setTitle(sensors[1], for: .normal)
        sensorButton3.setTitle(sensors[2], for: .normal)
        sensorButton4.setTitle(sensors[3], for: .normal)
        sensorButton5.setTitle(sensors[4], for: .normal)
    }
    
    // MARK: - Acciones de botones
    @IBAction func sensorButtonTapped(_ sender: UIButton) {
        if let sensorName = sender.titleLabel?.text {
            selectedSensor = sensorName
            sensorTypeLabel.text = sensorName
            updateGraphForSensor(sensorName)
        }
    }
    
    func updateGraphForSensor(_ sensorName: String) {
        sensorGraphView.subviews.forEach { $0.removeFromSuperview() }
        
        let chartView = SensorChartView(sensorData: sensorData, sensorName: sensorName)
        let hostingController = UIHostingController(rootView: chartView)
        
        guard let chartHostingView = hostingController.view else {
            return
        }
        
        sensorGraphView.addSubview(chartHostingView)
        chartHostingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chartHostingView.topAnchor.constraint(equalTo: sensorGraphView.topAnchor),
            chartHostingView.bottomAnchor.constraint(equalTo: sensorGraphView.bottomAnchor),
            chartHostingView.leadingAnchor.constraint(equalTo: sensorGraphView.leadingAnchor),
            chartHostingView.trailingAnchor.constraint(equalTo: sensorGraphView.trailingAnchor)
        ])
    }
}

