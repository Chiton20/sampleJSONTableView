//
//  ViewController.swift
//  sampleTableJSON
//
//  Created by sp4rt4n on 5/14/16.
//  Copyright © 2016 KrakenSoft. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

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
        cell.textLabel?.text = "Song: \(dataCell["title"] as! String)"
        cell.detailTextLabel?.text =  "Artist: \(dataCell["artist"] as! String)"
        let urlCover = dataCell["img_url"] as! String
        let url = urlCover.stringByReplacingOccurrencesOfString("http://fireflygrove.com/songnotes", withString: "http://www.songnotes.cc")
        let urlComposite = NSURL(string: url.stringByReplacingOccurrencesOfString(".png", withString: ".jpg"))
        cell.imageView?.af_setImageWithURL(urlComposite!, placeholderImage: UIImage (named: "cover_image"))
        /*
         cell.imageView!.af_setImageWithURL(urlComposite!,placeholderImage: nil, filter: nil, imageTransition: .None, completion: { (response) -> Void in
         print("image: \(self.image)")
         })
         */
        //print(urlCover.stringByReplacingOccurrencesOfString("http://fireflygrove.com/songnotes", withString: "http://www.songnotes.cc"))
        /*
        let url = NSURL(string: urlCover.stringByReplacingOccurrencesOfString("http://fireflygrove.com/songnotes", withString: "http://www.songnotes.cc"))
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let data = NSData(contentsOfURL: url!){
                dispatch_async(dispatch_get_main_queue(), {
                    cell.imageView!.image = UIImage(data: data)
                });

            }//make sure your image in this url does exist, otherwise unwrap in a if let check
            
                   }*/
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

