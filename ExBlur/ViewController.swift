//
//  ViewController.swift
//  ExBlur
//
//  Created by 김종권 on 2024/09/14.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = VC()
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
        
    }
}

class VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let items = (1...100).map(String.init)
    
    let tableView = UITableView()
    var blurView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    package override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "네비게이션 바 블러효과"
        setupBlurEffectToTopView()
    }

    func setupBlurEffectToTopView() {
        guard blurView == nil else { return }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        self.blurView = blurView
        
        let navigationBarBounds = navigationController?.navigationBar.bounds ?? .zero
        let window = UIApplication.shared.windows.first
        let safeAreaHeight = window?.safeAreaInsets.top ?? 0
        blurView.frame = .init(x: 0, y: 0, width: navigationBarBounds.width, height: navigationBarBounds.height + safeAreaHeight)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: [20, 25, 30, 35, 40, 80].randomElement()!)
        return cell
    }
}
