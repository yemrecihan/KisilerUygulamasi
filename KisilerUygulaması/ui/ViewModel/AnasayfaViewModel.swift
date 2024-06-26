//
//  AnasayfaViewModel.swift
//  KisilerUygulaması
//
//  Created by Yunus emre cihan on 24.06.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    var krepo = KisilerDaoRepository()
    
    init() {
        veritabaniKopyala()
        kisilerListesi = krepo.kisilerListesi
        kisileriYukle()
    }
    
    func sil(kisi_id:Int) {
        krepo.sil(kisi_id: kisi_id)
    }
    func ara(aramaKelimesi:String){
        krepo.ara(aramaKelimesi: aramaKelimesi)
    }
    func kisileriYukle(){
        
        krepo.kisileriYukle()
    }
    
    func veritabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "rehber", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath:hedefYol).appendingPathComponent("rehber.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Vertabanı zaten var")
        }else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{}
        }
    }
}
