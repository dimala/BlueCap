//
//  PeripheralAdvertisementsServicesViewController.swift
//  BlueCap
//
//  Created by Troy Stribling on 10/18/15.
//  Copyright © 2015 Troy Stribling. All rights reserved.
//

import UIKit
import BlueCapKit

class PeripheralAdvertisementsServicesViewController : UITableViewController {
    
    weak var peripheral: BCPeripheral?
    
    struct MainStoryboard {
        static let peripheralAdvertisementsServiceCell = "PeripheralAdvertisementsServiceCell"
    }
    
    required init?(coder aDecoder:NSCoder)  {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBecomeActive", name: BlueCapNotification.didBecomeActive, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didResignActive", name: BlueCapNotification.didResignActive, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func didResignActive() {
        self.navigationController?.popToRootViewControllerAnimated(false)
        BCLogger.debug()
    }
    
    func didBecomeActive() {
        BCLogger.debug()
    }
    
    // UITableViewDataSource
    override func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        return 1
    }
    
    override func tableView(_:UITableView, numberOfRowsInSection section:Int) -> Int {
        if let services = self.peripheral?.advertisements?.serviceUUIDs {
            return services.count
        } else {
            return 0;
        }
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.peripheralAdvertisementsServiceCell, forIndexPath: indexPath)
        if let services = self.peripheral?.advertisements?.serviceUUIDs {
            let service = services[indexPath.row]
            cell.textLabel?.text = service.UUIDString
        }
        return cell
    }

}
