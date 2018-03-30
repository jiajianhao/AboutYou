//
//  AViewController.swift
//  AboutYou
//
//  Created by 小雨科技 on 2018/3/28.
//  Copyright © 2018年 jiajianhao. All rights reserved.
//

import UIKit
import Alamofire

class AViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        self.title="1234"
        // Do any additional setup after loading the view.
        
        let button:UIButton = UIButton(type:.custom)
        //设置按钮位置和大小
        button.frame = CGRect(x:10, y:150, width:100, height:30)
        //设置按钮文字
        button.setTitle("按钮", for:.normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action:#selector(tapped), for:.touchUpInside)
  
    }
    func tapped() {
//        https://www.sojson.com/open/api/weather/json.shtml?city=北京
//        https://httpbin.org/get
        Alamofire.request("https://httpbin.org/get?key2=value2&key1=value1").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
//        self.navigationController?.popViewController(animated: true)
    }
    func getWeather()  {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
