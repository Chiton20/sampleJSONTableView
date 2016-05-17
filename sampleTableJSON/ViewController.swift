//
//  ViewController.swift
//  sampleTableJSON
//
//  Created by sp4rt4n on 5/14/16.
//  Copyright © 2016 KrakenSoft. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //Seccion de outlets
    @IBOutlet weak var tblSongs: UITableView!
    
    //Seccion de variables
    var arraySongs = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadSongs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Metodos delegados obligatorios de implementación para usar el TableView
    
    //método para definir cuantas secciones tendra el tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySongs.count
    }
    //método que pobla cada celda de la Tabla
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSong",forIndexPath: indexPath);
        let dataCell = arraySongs[indexPath.row]
        cell.textLabel?.text = dataCell["artist"] as? String
        
        return cell
    }
    
    func loadSongs()  {
        Alamofire.request(.GET,"http://davidpots.com/jakeworry/017%20JSON%20Grouping,%20part%203/data.json").responseJSON{ response in
            switch response.result {
            case .Success:
                print("Validation Successful")
                if let JSON = response.result.value{
                    self.arraySongs = JSON["songs"]as! NSArray
                    self.tblSongs.reloadData()
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }
}

