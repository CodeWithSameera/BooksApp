        //
        //  ViewController.swift
        //  BooksApp
        //
        //  Created by Sameera Madushan on 2022-01-13.
        //
        
        import UIKit
        import Alamofire
        import SwiftyJSON
        import Kingfisher
        class ViewController: UIViewController,UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                arrRes.count
            }
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 150
            }
            func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let postion = scrollView.contentOffset.y
                
                if(postion>(booksTable.contentSize.height-100-scrollView.frame.size.height)){
                    if(loadmore && !loading){
                        self.loaddata();
                    }
                }
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell : CustomCell = tableView.dequeueReusableCell(withIdentifier: "custom_cell")! as! CustomCell
                var dict = arrRes[indexPath.row]
                var subdict = dict["volumeInfo"]
                var imgdict = subdict?["imageLinks"] as? [String: Any]
                cell.title?.text = subdict!["title"] as? String
                cell.dis?.text = subdict!["description"] as? String
                var uuu =  imgdict!["thumbnail"] as? String ?? "https://picsum.photos/200/300/?blur"
                
                let imgurl=URL(string:uuu)
                cell.img.kf.setImage(with: imgurl)
                return cell            }
            
            
            @IBOutlet weak var booksTable: UITableView!
            var arrRes = [[String:AnyObject]]()
            var page = 0;
            var loading = false;
            var loadmore = true;
            override func viewDidLoad() {
                super.viewDidLoad()
                booksTable.delegate=self
                booksTable.dataSource=self
                loaddata()
            }
            
            func loaddata(){
                self.loading = true;
                let apiurl = "https://www.googleapis.com/books/v1/volumes?q=flowers&startIndex="+String(page)+"&maxResults=10"
                AF.request(apiurl).responseJSON { (responseData) -> Void in
                    if((responseData.result) != nil) {
                        let json = try? JSON(data: responseData.data!)
                        if let resData = json!["items"].arrayObject {
                            let newarray :  [[String:AnyObject]] = resData as! [[String:AnyObject]]
                            if(newarray.count == 10){
                                self.page += 1
                            }else{
                                self.loadmore = false
                            }
                            
                            self.arrRes.append(contentsOf: newarray)
                        }
                        if self.arrRes.count > 0 {
                            self.booksTable.reloadData()
                            self.loading = false
                        }
                    }
                }
                
            }
            
        }
        
