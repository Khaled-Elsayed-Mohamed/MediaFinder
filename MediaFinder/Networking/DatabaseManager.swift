import Foundation
import SQLite

class DatabaseManager {
    
    
    private static let sharedInstance = DatabaseManager()
    
    private var database: Connection!
    private let lastSearch = Expression<String>("lastSearch")
    let usersTable = Table("users")
    let accountsTable = Table("accounts")
    private let email = Expression<String>("email")
    private let name = Expression<String>("name")
    private let password = Expression<String>("password")
    private let profileImage = Expression<Data>("profileImage")
    private let address = Expression<String>("address")
    private let id = Expression<Int>("id")
    private let searchId = Expression<Int>("searchId")
    
    static func shared() -> DatabaseManager {
        return DatabaseManager.sharedInstance
    }


    func dataBaseConnection() {
    do {
        let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
        let database = try Connection(fileUrl.path)
        self.database = database
        } catch {
        print(error)
        }
    }

    func createTable() {
    let createTabel = self.usersTable.create { (table) in
        
        table.column(self.lastSearch)
        table.column(self.searchId, primaryKey: true)
        }
        do {
        
        try self.database.run(createTabel)
        print("created Tabel")
        
        } catch { print(error) }
    }
    
    func createAccountsTable() {
        let createAccountsTable = self.accountsTable.create { (table) in
            
            table.column(self.name)
            table.column(self.email)
            table.column(self.password)
            table.column(self.profileImage)
            table.column(self.address)
            table.column(self.id, primaryKey: true)

        }
        do {
            
            try self.database.run(createAccountsTable)
            print("created Tabel")
            
        } catch { print(error) }
    }


    func insertData(text: String) {
    let insertUser = self.usersTable.insert(self.lastSearch <- text)
        do {
        
        try self.database.run(insertUser)
        
        } catch { print(error) }
    }
    
    func insertAccounts(name: String, email: String, password: String, profileImage: Data, address: String) {
        let insertAccount = self.accountsTable.insert(self.name <- name, self.email <- email, self.password <- password, self.profileImage <- profileImage, self.address <- address)
        do {
            
            try self.database.run(insertAccount)
            
        } catch { print(error) }
    }
    
    func listAccounts(email: String, password: String) -> Bool {
        print("list tapped")
        
        do {
            let accounts = try database.prepare(self.accountsTable)
            for account in accounts {
                if email == account[self.email] && password == account[self.password] {
                UserDefaults.standard.set(account[self.id], forKey: "id")
                    return true
            }
        }
    } catch { print(error) }
        return false
    }
    
    func cacheUserExist() -> Bool {
        
        do {
            let id = UserDefaults.standard.integer(forKey: "id")
            
            let cacheData = try database.prepare(self.usersTable)
            
            for data in cacheData {
                if data[self.searchId] == id {
                    return true
                }
            }
        } catch { print(error) }
            return false
    }
    
    func getCacheData() -> String? {
        
        let id = UserDefaults.standard.integer(forKey: "id")
        do {
            let cacheData = try database.prepare(self.usersTable)
            for data in cacheData {
                if id == data[self.searchId] {
                    return data[self.lastSearch]
                }
            }
        } catch { print(error) }
            return nil
    }
    
    func updateCacheData(text: String) {
        if cacheUserExist() == true {
            let id = UserDefaults.standard.integer(forKey: "id")
            let user = self.usersTable.filter(self.searchId == id)
            let updateUser = user.update(self.lastSearch <- text)
        
        do {
           
           try self.database.run(updateUser)
            
            
        } catch { print(error) }
        
           
            }
        else { self.insertData(text: text)
        }
    
    }
    
    func getIdData() -> User? {
        let id = UserDefaults.standard.integer(forKey: "id")
        
        do {
            let accounts = try database.prepare(self.accountsTable)
            for account in accounts {
                if account[self.id] == id {
                   return User(name: account[self.name], email: account[self.email], password: account[self.password], profileImage: account[self.profileImage], address: account[self.address])
                }
            }
        } catch { print(error) }
        return nil
    }
    
    func checkTable(table: Table) -> Bool {
        
        do {
            if try database.scalar(table.exists) {
                return true
                
            }
        } catch {
            print(error)
        }
        return false
    }
    
    func updateSearch(text: String) {
        
        let updateUser = usersTable.update(self.lastSearch <- text)
        do {
            try self.database.run(updateUser)
        } catch {
            print(error)
        }
    }
}








