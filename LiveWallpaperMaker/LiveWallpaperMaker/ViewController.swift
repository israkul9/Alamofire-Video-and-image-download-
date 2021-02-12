//
//  ViewController.swift
//  LiveWallpaperMaker
//
//  Created by Twinbit Limited on 10/2/21.
//

import UIKit
import PhotosUI
import Photos
import Alamofire

//http://api.twinbit.net/wallpaper/uploads/images/1612342363live_wallpaper_2.JPG
//http://api.twinbit.net/wallpaper/uploads/images/1612342364live_wallpaper_2.mov

let imageURL = URL(string: "http://api.twinbit.net/wallpaper/uploads/images/1612342304live_wallpaper_1.JPG")
let videoURL = URL(string: "http://api.twinbit.net/wallpaper/uploads/images/1612342305live_wallpaper_1.mov")

class ViewController: UIViewController {
    
    var livePhotoview = PHLivePhotoView()

    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        livePhotoview = PHLivePhotoView(frame: self.view.bounds)
        
        imageView = UIImageView(frame: self.view.bounds)
        
        view.addSubview(imageView)
        view.addSubview(livePhotoview)
        
        view.backgroundColor = .orange
        
        if let photoFilename = imageURL?.lastPathComponent,
           let videoFilename = videoURL?.lastPathComponent{
            
            if DocManager.doesFileExist("Video", fileName: videoFilename)  && DocManager.doesFileExist("Photo", fileName: photoFilename){
                print("---------------------------------")
                print("File Already exists in Document directory")
                print("---------------------------------")
                playLivePhoto(photoFilename:photoFilename, videoFilename: videoFilename)
            }
            else{
                
                print("---------------------------")
                print("Not found. Need to download both photo and video")
                print("---------------------------")
                
                
                downloadVideoUsingAlamofire(url: videoURL!, fileName: videoFilename,folderName: "Video")
                downloadPhotoUsingAlamofire(url: imageURL!, fileName: photoFilename,folderName: "Photo")
              
            
                
            }
        }
        
        
    }
    
    
    
    func getPhotoFileName (photoUrl : URL) ->String {
        return photoUrl.lastPathComponent
    }
    
    
    func getVideoFileName (videoUrl : URL) ->String {
        return videoUrl.lastPathComponent
    }
    
    
  
    // MARK: - Load URL
    
    func downloadPhotoUsingAlamofire(url: URL, fileName: String, folderName: String) {
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let folderURL = documentsURL.appendingPathComponent(folderName)
            let fileURL = folderURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(url.absoluteString, to: destination).downloadProgress { progress in
            
            let x = (progress.fractionCompleted)*100
            
            let y = (x*100).rounded()/100
            
            print("Photo Download Progress: \(y)  %")
        }.response { response in
            
            debugPrint(response)
            
          //  print(response , "Here the RESPONSE IS")

            if response.error == nil{

                if DocManager.doesFileExist("Photo", fileName: imageURL!.lastPathComponent) && DocManager.doesFileExist("Video", fileName: videoURL!.lastPathComponent){
                    self.playLivePhoto(photoFilename: imageURL!.lastPathComponent, videoFilename:videoURL!.lastPathComponent )
                }
               
                
            }
        }
       
    }
    
    func downloadVideoUsingAlamofire(url: URL, fileName: String, folderName: String) {
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let folderURL = documentsURL.appendingPathComponent(folderName)
            let fileURL = folderURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(url.absoluteString, to: destination).downloadProgress { progress in
            let x = (progress.fractionCompleted)*100
            
            let y = (x*100).rounded()/100 // fraction 2 digit nibe
            
            print("Video Download Progress: \(y)  %")
        }.response { response in
            debugPrint(response)

            print(response , "Here the RESPONSE IS")
            
            if response.error == nil {
                
               
                if DocManager.doesFileExist("Photo", fileName: imageURL!.lastPathComponent) && DocManager.doesFileExist("Video", fileName: videoURL!.lastPathComponent){
                  
                    self.playLivePhoto(photoFilename: imageURL!.lastPathComponent, videoFilename:videoURL!.lastPathComponent )
                }
                
            }
            

        }
        
       
    }
    
    
    private func playLivePhoto( photoFilename:String, videoFilename:String){
        
    if let photourl = DocManager.getFileURL("Photo", fileName: photoFilename), let videoURL = DocManager.getFileURL("Video", fileName: videoFilename)
        {
            
            LivePhoto.generate(from: photourl, videoURL: videoURL) { (percent) in
                
            } completion: { (livePhoto, resource) in
                self.livePhotoview.livePhoto = livePhoto
                self.livePhotoview.startPlayback(with: .full)
            }

        }
    }


}

