//
//  ViewController.swift
//  ApiSearchItunes
//
//  Created by Brieuc Caillot on 28/03/2019.
//  Copyright © 2019 Brieuc Caillot. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchMusicViewController: UIViewController, UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputSearch: UITextField!
    var albumList:[AlbumClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputSearch.returnKeyType = UIReturnKeyType.search
        inputSearch.delegate = self
        getAlbumsFromArtist(artist:"drake")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath ) as! CustomCell
        
        let album = albumList[indexPath.row]
        
        let imgUrl = URL(string: album.albumImg)
        let dataImg = try? Data(contentsOf: imgUrl!)
        
        customCell.albumImg.image = UIImage(data : dataImg!)
        customCell.albumTrackname.text! = album.albumTrack
        customCell.albumArtist.text! = album.albumArtist
        
        return customCell
    }
    
    func getAlbumsFromArtist(artist:String){
        
        let artistModifed = artist.replacingOccurrences(of: " ", with: "%20")
        
        print(artistModifed)
        
        albumList.removeAll(keepingCapacity: true)
        Alamofire.request("https://itunes.apple.com/search?term=\(artistModifed)",
            method: .get,
            encoding: URLEncoding.default).responseJSON {

                response in
            switch response.result {
            case .success:
                
                if let json = response.result.value {
                    let j = JSON(json)
                    
                    for i in 0..<j["results"].count {
                        
                        let artistName = j["results"][i]["artistName"].stringValue
                        let trackName = j["results"][i]["trackName"].stringValue
                        let img = j["results"][i]["artworkUrl60"].stringValue
                        
                        let result = AlbumClass()
                        
                        result.albumImg = img
                        result.albumArtist = "\(artistName)"
                        result.albumTrack = "\(trackName)"
                        
                        self.albumList.append(result)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getAlbumsFromArtist(artist: inputSearch.text!)
        textField.resignFirstResponder()
        return true
    }
    

}

