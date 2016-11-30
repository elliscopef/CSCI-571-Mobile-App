//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //need to override it with the legislator info
    var mainContens = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(DataTableViewCell.self)
        
        Alamofire.request("http://sample-env-1.hamjeipu3q.us-west-2.elasticbeanstalk.com/index.php?category=legistlator").responseJSON { response in
            
            var data  = JSON(response.result.value)
            print(data["results"])
            
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var searchEngineURLString: NSString! = "";
        
        switch item.tag  {
        case 0:
            searchEngineURLString = "https://www.bing.com"
            print(searchEngineURLString)
            break
        case 1:
            searchEngineURLString = "https://www.duckduckgo.com"
            print(searchEngineURLString)
            break
        case 2:
            searchEngineURLString = "https://www.google.com"
            print(searchEngineURLString)
            break
        default:
            searchEngineURLString = "https://www.des.com"
            print(searchEngineURLString)
            break
        }
        
//        loadSearchEngine(searchEngineURLString);
    }
//    
//    func loadSearchEngine(searchEngineURLString: NSString!) {
//        var searchEngineURL = NSURL(string: searchEngineURLString)
//        var searchEngineURLRequest = NSURLRequest(URL: searchEngineURL)
//        webView.loadRequest(searchEngineURLRequest)
//    }
}


extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataTableViewCell.height()
    }
    
    //the part of code that navigates towards to the subcontentViewController. Need to pass in parameters.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentsViewController") as! SubContentsViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainContens.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
        let data = DataTableViewCellData(imageUrl: "dummy", text: mainContens[indexPath.row])
        cell.setData(data)
        return cell
    }
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
}
