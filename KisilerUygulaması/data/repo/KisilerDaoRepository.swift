import Foundation
import RxSwift

class KisilerDaoRepository {
    
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    let db: FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath:hedefYol).appendingPathComponent("rehber.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func kaydet(kisi_ad:String,kisi_tel:String){
        db?.open()
        var liste = [Kisiler]()

        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)", values: [kisi_ad,kisi_tel])

        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }
    
    func guncelle(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        db?.open()
        var liste = [Kisiler]()

        do {
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad = ?, kisi_tel = ? WHERE kisi_id = ?", values: [kisi_ad,kisi_tel,kisi_id])

        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }
    
    func sil(kisi_id:Int) {
        db?.open()
        var liste = [Kisiler]()

        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
            kisileriYukle()
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
        
    }
    func ara(aramaKelimesi:String){
        db?.open()
        var liste = [Kisiler]()

        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler where kisi_ad like '%\(aramaKelimesi)%'", values: nil)

            while rs.next() {
                if let kisi_id = Int(rs.string(forColumn: "kisi_id") ?? "0"),
                   let kisi_ad = rs.string(forColumn: "kisi_ad"),
                   let kisi_tel = rs.string(forColumn: "kisi_tel") {

                    let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                    liste.append(kisi)
                } 
            }
            kisilerListesi.onNext(liste)
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }
    
    func kisileriYukle() {
        db?.open()
        var liste = [Kisiler]()

        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler", values: nil)

            while rs.next() {
                if let kisi_id = Int(rs.string(forColumn: "kisi_id") ?? "0"),
                   let kisi_ad = rs.string(forColumn: "kisi_ad"),
                   let kisi_tel = rs.string(forColumn: "kisi_tel") {

                    let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                    liste.append(kisi)
                }
            }
            kisilerListesi.onNext(liste)
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }


   /* func kisileriYukle(){
        db?.open()
        var liste = [Kisiler]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while rs.next() {
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id"))!,
                                   kisi_ad: rs.string(forColumn: "kisi_ad")!,
                                   kisi_tel: rs.string(forColumn: "kisi_tel")!)
                
                liste.append(kisi)
            }
            kisilerListesi.onNext(liste)
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }*/
}
