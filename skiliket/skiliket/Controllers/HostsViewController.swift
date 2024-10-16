//
//  HostsViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 08/10/24.
//

import UIKit

class HostsViewController: UIViewController {

    var selectedHost:Response = Response(connectedAPMACAddress: "", connectedAPName: "", connectedInterfaceName: "", connectedNetworkDeviceIPAddress: "", connectedNetworkDeviceName: "", hostIP: "", hostMAC: "", hostName: "", hostType: "", id: "", lastUpdated: "", pingStatus: "", vlanID: "")
    

    @IBOutlet weak var hostName: UILabel!
    
    @IBOutlet weak var hostIpPAddress: UILabel!
    
    @IBOutlet weak var hostLocalization: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hostName.text = selectedHost.hostName
        hostIpPAddress.text = selectedHost.connectedInterfaceName
        hostLocalization.text = selectedHost.hostIP
    }

}
