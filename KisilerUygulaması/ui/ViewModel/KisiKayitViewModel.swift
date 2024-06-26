//
//  KisiKayitViewModel.swift
//  KisilerUygulaması
//
//  Created by Yunus emre cihan on 24.06.2024.
//

import Foundation

class KisiKayitViewModel {
    
    var krepo = KisilerDaoRepository()
    
    func kaydet(kisi_ad:String,kisi_tel:String){
        krepo.kaydet(kisi_ad: kisi_ad, kisi_tel: kisi_tel)
        
    }

}
