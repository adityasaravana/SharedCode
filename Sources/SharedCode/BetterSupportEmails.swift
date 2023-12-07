//
//  File.swift
//  
//
//  Created by NMS15065-8-adisara on 11/30/23.
//

// MARK: Imports
import Foundation
import SwiftUI
import OSInfo

// MARK: Email To Route Support Emails To
let to = "aditya.saravana@icloud.com"

// MARK: Bundle Extensions
extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var appBuild: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}


// MARK: Email Sending
#if canImport(MessageUI)
import MessageUI

public class EmailController: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailController()
    public override init() {}
    
    func sendEmail(subject: String, body: String) {
        // Check if the device is able to send emails
        if !MFMailComposeViewController.canSendMail() {
           print("This device cannot send emails.")
           return
        }
        // Create the email composer
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([to])
        mailComposer.setSubject(subject)
        mailComposer.setMessageBody(body, isHTML: false)
        EmailController.getRootViewController()?.present(mailComposer, animated: true, completion: nil)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailController.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
    static func getRootViewController() -> UIViewController? {
        // In SwiftUI 2.0
        UIApplication.shared.windows.first?.rootViewController
    }
}
#else
public class EmailController {
    func createMailtoLink(subject: String, body: String) -> String {
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        return "mailto:\(to)?subject=\(encodedSubject)&body=\(encodedBody)"
    }
}
#endif

// MARK: BetterSupportEmails
struct BetterSupportEmails {
    @Environment(\.openURL) private var openURL
    let appName = Bundle.main.displayName ?? ""
    let appVersion = Bundle.main.appVersion ?? "Version not found"
    let appBuild = Bundle.main.appBuild ?? "Build not found"
    let osVersion: String = OS.current.name + OS.current.displayVersion
    
    var body: String {
        return
"""
Hey Aditya,



Sincerely,
[your name here]


- DEBUG INFO ---------------------------------------------------------------------------
--- Please don't delete these, they help me diagnose problems and ship fixes faster. ---
--- App: \(appName)                                                                  ---
--- App Version: \(appVersion)                                                       ---
--- App Build: \(appBuild)                                                           ---
--- OS Version: \(osVersion)                                                         ---
----------------------------------------------------------------------------------------
"""
    }
    
    init() {
        
    }
    
    func openEmailView() {
#if canImport(MessageUI)
        EmailController().sendEmail(subject: "\(appName) ", body: body)
#else
        openURL(URL(string: EmailController().createMailtoLink(subject: "\(appName) ", body: body))!)
#endif
    }
}
