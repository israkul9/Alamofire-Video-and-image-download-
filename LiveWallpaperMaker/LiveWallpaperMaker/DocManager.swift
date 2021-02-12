//
//  DocManager.swift
//  LiveWallpaperMaker
//
//  Created by Twinbit Limited on 10/2/21.
//

import Foundation

class DocManager : NSObject{
    
    
    @objc public class func  makeFolder(_ folderName : String){
        
            // create folder in document dir with name folderName
        createFileDirectory(folderName)
        
    }
    
    
    @objc public class func  createFolder(){
        
    }
    
    @objc public class func  writeFolder(){
        
    }
    
    @objc public class func  deleteFolder(){
        
    }
    

    class func documentsPathForFileName() -> String {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            return documentsPath
        }
    
    class func createFileDirectory(_ folderName : String) {
        
        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            //set the name of the new folder
        let folderURL = documentsURL.appendingPathComponent(folderName)
        do
        {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        catch let error as NSError
        {
            print("Unable to create directory \(error.debugDescription)")
        }
    }
    
    @objc public class func listFilesInDoucumentsDir(_ folderName:String)-> URL?{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let folderURL = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            let subFolderURL = folderURL[0].appendingPathComponent(folderName)
            // process files
            return subFolderURL
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        return nil
    }
    
    @objc public class func listAllFilesInDir(_ folderName:String)-> [URL]?{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let folderURL = documentsURL.appendingPathComponent("LiveWallpapers").appendingPathComponent(folderName)
            let subFolderURL = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            
            // process files
            return subFolderURL
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        return nil
    }
    
    
    @objc public class func getFilesURLInDoucumentsDir(_ folderName:String)-> [URL]?{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let folderURL = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            let subFolderURL = folderURL[0].appendingPathComponent(folderName)
            // process files
            let fileURLArray = try fileManager.contentsOfDirectory(at: subFolderURL, includingPropertiesForKeys: nil)
            return fileURLArray
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        return nil
    }
    
    @objc public class func doesFileExist(_ folderName : String , fileName : String) -> Bool
    {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var fileExist = false
        
        let subFolderURL = documentsURL.appendingPathComponent(folderName)
        //let filename = h.appendingPathComponent(fileName)
        
        do {
//            let folderURL = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//            let subFolderURL = folderURL[0].appendingPathComponent(folderName)
            // process files
            
            let fileURLs = try fileManager.contentsOfDirectory(at: subFolderURL, includingPropertiesForKeys: nil)
            
            for fileURL in fileURLs{
                let lastComponent = fileURL.lastPathComponent
                if(fileName == lastComponent){
                    fileExist = true
                    return fileExist
                }
            }
            
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        return fileExist
    }
    
    @objc public class func getFileURL(_ folderName : String , fileName : String) -> URL?
    {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let h = documentsDirectory.appendingPathComponent(folderName)
        let filename = h.appendingPathComponent(fileName)
           // return documentsDirectory
        return filename
        
//        do {
//            let folderURL = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//            let subFolderURL = folderURL[0].appendingPathComponent(folderName)
//            // process files
//
//            let fileURLs = try fileManager.contentsOfDirectory(at: subFolderURL, includingPropertiesForKeys: nil)
//
//            for fileURL in fileURLs{
//                let lastComponent = fileURL.lastPathComponent
//                if(fileName == lastComponent){
//
//                    return fileURL
//
//                }
//            }
//
//        } catch {
            //print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
//        }
//        return nil
    }
    
    @objc public class func getFolderURL(_ folderName : String) -> URL?
    {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let h = documentsDirectory.appendingPathComponent(folderName)
           // return documentsDirectory
        return h
//        let fileManager = FileManager.default
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//
//        do {
//            let folderURL = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//            let subFolderURL = folderURL[0].appendingPathComponent(folderName)
//            // process files
//
//            return subFolderURL
//
//        } catch {
//            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
//        }
//        return nil
    }
    
    @objc public class func deleteFile(_ fileURL : URL)
    {
        let fileManager = FileManager.default
        
        do {
            
            try fileManager.removeItem(at: fileURL)
            
        } catch {
            print("Could not delete file \(fileURL)")
        }
    }
    
}

@objc public class NetworkClass : NSObject{
    
//    @objc public class func  downloadVideoData(_ url : URL){
//
//        let fileURLs = FolderModel.listFilesInDoucumentsDir()
//
//        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        var filePath = documentsURL.appendingPathComponent("\\LiveVideo\\liveWallpaper.mov")
//
//        for fileURL in fileURLs!{
//            let lastPath : String = fileURL.lastPathComponent
//
//            if(lastPath == "LiveVideo")
//            {
//                filePath = fileURL
//                break
//            }
//
//            let strURL = fileURL.absoluteString
//            print(strURL)
//        }
//
//        AF.request(url).downloadProgress { (progress) in
//
//            var dic = Dictionary<String, Any>()
//            print("video downloading progress : ", progress.fractionCompleted)
//            dic["progress"] = progress.fractionCompleted
//            dic["url"] = url
//
//            NotificationCenter.default.post(name: Notification.Name("progress"), object: dic)
//
//
//        }.response { (responseData) in
//            print(responseData.result)
//            print(responseData)
//            print(responseData.result)
//
//            let fileName = url.lastPathComponent
//
//            filePath = filePath.appendingPathComponent(fileName)
//
//            let videoAsData = responseData.data
//
//            do{
//                try videoAsData?.write(to: filePath)
//            }catch let error{
//                print("Error in writing video data", error)
//            }
//
//        }
//
//
//    }
//
//    @objc public class func  downloadImageData(_ url : URL){
//
//        let fileURLs = FolderModel.listFilesInDoucumentsDir()
//
//        let documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        var filePath = documentsURL.appendingPathComponent("\\LiveVideo\\liveWallpaper.jpg")
//
//        for fileURL in fileURLs!{
//            let lastPath : String = fileURL.lastPathComponent
//
//            if(lastPath == "LivePlaceHolder")
//            {
//                filePath = fileURL
//                break
//            }
//
//            let strURL = fileURL.absoluteString
//            print(strURL)
//        }
//
//        AF.request(url).downloadProgress { (progress) in
//            print("image downloading progress : ",progress.fractionCompleted)
//        }.response { (responseData) in
//            print(responseData.result)
//            print(responseData)
//            print(responseData.result)
//
//            let fileName = url.lastPathComponent
//
//            filePath = filePath.appendingPathComponent(fileName)
//
//            let imageData = responseData.data
//
//            do{
//                try imageData?.write(to: filePath)
//            }catch let error{
//                print("Error in writing video data", error)
//            }
//
//        }
//
//
//    }
}

