import UIKit
import AVKit
import AVFoundation


class MoviesListVC: UIViewController {
    
    var moviesArr = [resultsData]()
    fileprivate let cellIdentifier = "CustomCell"
    let playerVC = AVPlayerViewController()
    var database = DatabaseManager.shared()
    let search = UISearchBar()
    var indicator = UIActivityIndicatorView()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmantedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        segmantedControl.selectedSegmentIndex = 0
        segmantedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        search.delegate = self
        
        registerCell()
        customizeNavItems()
        createIndicator()
        activityIndicator()
        database.dataBaseConnection()
        
        
        getData(search: database.getCacheData() ?? "")
        tableCellResize()
        buildSearch()
        navigationTitleView()
        
        
    }
    
   
    
    func tableCellResize() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
    }
  
    
    func getData(search: String) {
        indicator.startAnimating()
        APIManager.loadMovies(search: search) { (error, movies) in
            if let error = error {
                print(error.localizedDescription)
            } else if let movies = movies {
                self.moviesArr = movies
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                
            }
        }
    }
}

// table view config.
extension MoviesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func registerCell() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArr.count == 0 {
            self.tableView.setEmptyView(title: "no search results", message: "couldnt find resutls for you search")
        }
        return moviesArr.count
        
        
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.configureCellData(data: moviesArr[indexPath.row])
        cell.shadowAndBorderForCell(yourTableViewCell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let mediaURL = URL(string: moviesArr[indexPath.row].previewUrl ?? "") else { return }
        let player = AVPlayer(url: mediaURL)
    
        self.playerVC.player = player
        self.showDetailViewController(playerVC, sender: self)
        self.playerVC.player?.play()
    }
    
}


// search bar config.
extension MoviesListVC: UISearchBarDelegate {
    
    func buildSearch() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        search.sizeToFit()
        
    }
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        search.becomeFirstResponder()
    }
    
    @objc fileprivate func handleSegmentChange() {
        print(segmantedControl.selectedSegmentIndex)
        
        switch segmantedControl.selectedSegmentIndex {
        case 2:
            parameters.scope = MediaType.music.rawValue
        case 1:
            parameters.scope = MediaType.tvShow.rawValue
        case 3:
            parameters.scope = MediaType.movie.rawValue
            
        default:
            parameters.scope = MediaType.all.rawValue
        }
        getData(search: database.getCacheData() ?? "")
        tableView.reloadData()
        
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationTitleView()
        } else {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        search.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? search: nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    
    
    func  searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = search.text else { return }
     
        
        getData(search: text)
       
        
        database.updateCacheData(text: text)
        
        }
    }

// loader
extension MoviesListVC {

    
    func createIndicator() {
        let activityIndicatorView = UIActivityIndicatorView()
        tableView.backgroundView = activityIndicatorView
    }
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = .darkGray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
}

// navigation bar customize
extension MoviesListVC {
    
    @objc func goToProfileVC() {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    func customizeNavItems() {
    navigationItem.title = "Media list"
    navigationController?.isNavigationBarHidden = false
    navigationItem.hidesBackButton = true
    buildSearch()
        
    navigationController?.navigationBar.prefersLargeTitles = true
    
    }
    
    func navigationTitleView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        
    }
}


// cell card design & auto resize
extension UITableViewCell {
    func shadowAndBorderForCell(yourTableViewCell : UITableViewCell){
        yourTableViewCell.contentView.layer.cornerRadius = 25
        yourTableViewCell.contentView.layer.borderWidth = 1
        yourTableViewCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        yourTableViewCell.contentView.layer.masksToBounds = true
        yourTableViewCell.layer.shadowColor = UIColor.white.cgColor
        yourTableViewCell.layer.shadowOffset = CGSize(width: 1, height: 1)
        yourTableViewCell.layer.shadowRadius = 3
        yourTableViewCell.layer.shadowOpacity = 3
        yourTableViewCell.layer.masksToBounds = true
        yourTableViewCell.layer.shadowPath = UIBezierPath(roundedRect:yourTableViewCell.bounds, cornerRadius:yourTableViewCell.contentView.layer.cornerRadius).cgPath
    }
    
    
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
