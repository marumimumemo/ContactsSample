//
//  ViewController.swift
//  ContactsSample
//
//  Created by satoshi.marumoto on 2020/04/07.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    let contactStore = CNContactStore()
    let request = CNSaveRequest()
    let contact = CNMutableContact()
    let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func buttonTapped(){
        switch status {
        case .notDetermined, .restricted:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if let error = error {
                    print(error)
                }
                if granted {
                    self.registerContactApp()
                } else {
                    // アラートからアクセスの許可をしてもらえなかった時
                }
            }
        case .denied: break
            // 拒否されている場合
        case .authorized: break
            // すでにアクセスが許可されている場合
        default: break
            // それ以外の場合
        }
    }
    
    func registerContactApp() {
        
        contact.givenName = "名前"
        contact.familyName = "名字"
        contact.phoneticGivenName = "なまえ"
        contact.phoneticFamilyName = "みょうじ"
        contact.organizationName = "会社名"
        contact.phoneticOrganizationName = "かいしゃめい"
        contact.phoneNumbers = [
            CNLabeledValue<CNPhoneNumber>(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: "123-4567-8910")),
            CNLabeledValue<CNPhoneNumber>(label: "カスタムのラベル", value: CNPhoneNumber(stringValue: "123-4567-8910"))
        ]
        contact.emailAddresses = [
            CNLabeledValue<NSString>(label: CNLabelHome, value: NSString(string: "sample@sample.com")),
            CNLabeledValue<NSString>(label: CNLabelWork, value: NSString(string: "sample@sample.com"))
        ]
        contact.urlAddresses = [CNLabeledValue<NSString>(label: CNLabelURLAddressHomePage, value: NSString(string: "https://www.apple.com/jp/"))]
        let address = CNMutablePostalAddress()
        address.country = "日本"
        address.postalCode = "123-4567"
        address.state = "〇〇県"
        address.city = "〇〇市"
        address.street = "〇〇区〇〇丁目1−1"
        
        contact.postalAddresses = [CNLabeledValue<CNPostalAddress>(label: CNLabelHome, value: address)]
        
        request.add(contact, toContainerWithIdentifier: contactStore.defaultContainerIdentifier())
        
        do {
            try contactStore.execute(request)
        } catch {
            print(error)
        }
    }


}
