//
//  ViewController.swift
//  AgoraVideoCall
//
//  Created by jay kumbhani on 09/07/22.
//
// AGora Id- 8adfffd0cc86425c9c4f616e98646cf1

import UIKit
import AgoraRtcKit

class ViewController: UIViewController {
    
    var localView: UIView!
    var remoteView: UIView!
    var agoraKit: AgoraRtcEngineKit?
    
    let AppID: String = "8adfffd0cc86425c9c4f616e98646cf1"
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initializeAndJoinChannel()
    }

    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         agoraKit?.leaveChannel(nil)
         AgoraRtcEngineKit.destroy()
     }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          remoteView.frame = self.view.bounds
          localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
      }

      func initView() {
          localView = UIView()
          self.view.addSubview(localView)
          remoteView = UIView()
          self.view.addSubview(remoteView)
      }
    func initializeAndJoinChannel() {
      // Pass in your App ID here
      agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: self)
      // For a live streaming scenario, set the channel profile as liveBroadcasting.
      agoraKit?.setChannelProfile(.liveBroadcasting)
      // Set the client role as broadcaster or audience.
      agoraKit?.setClientRole(.broadcaster)
      // Video is disabled by default. You need to call enableVideo to start a video stream.
      agoraKit?.enableVideo()
           // Create a videoCanvas to render the local video
           let videoCanvas = AgoraRtcVideoCanvas()
           videoCanvas.uid = 0
           videoCanvas.renderMode = .hidden
           videoCanvas.view = localView
           agoraKit?.setupLocalVideo(videoCanvas)

      // Join the channel with a token. Pass in your token and channel name here
      agoraKit?.joinChannel(byToken: "0069724c0b515be46e5a2bb94895943bd31IABH9uTErM5FKv98GP79iAUZ4yGOQbFj3Jocg0s40zDG/KDfQtYAAAAAEADLkLYo16vKYgEAAQDXq8pi", channelId: "demo", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
           })
       }
}


extension ViewController: AgoraRtcEngineDelegate {
    // This callback is triggered when a remote host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        agoraKit?.setupRemoteVideo(videoCanvas)
        print("hello jay")
    }
}

