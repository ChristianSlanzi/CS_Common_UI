//
//  ContainerController.swift
//  FitGoal
//
//  Created by Christian Slanzi on 07.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public struct ContainerControllerModel {
    var navigationItemTitle: String
    var collectionRowHeight: CGFloat
    var tableRowHeight: CGFloat
    
    //TODO create a section header model
    var sectionTitles: [String]
    var sectionTitleHexColor: String //#ffffff
    var sectionMoreButtonTitles: [String]
    var sectionMoreButtonTitleHexColor: String //#ffffff
    
    public init(navigationItemTitle: String,
                collectionRowHeight: CGFloat,
                tableRowHeight: CGFloat,
                sectionTitles: [String],
                sectionTitleHexColor: String,
                sectionMoreButtonTitles: [String],
                sectionMoreButtonTitleHexColor: String
                ) {
        self.navigationItemTitle = navigationItemTitle
        self.collectionRowHeight = collectionRowHeight
        self.tableRowHeight = tableRowHeight
        self.sectionTitles = sectionTitles
        self.sectionTitleHexColor = sectionTitleHexColor
        self.sectionMoreButtonTitles = sectionMoreButtonTitles
        self.sectionMoreButtonTitleHexColor = sectionMoreButtonTitleHexColor
    }
}

public class ContainerController<T, Cell: UICollectionViewCell, U, UCell: UITableViewCell>: UITableViewController
where Cell: ConfigurableCell, Cell: CoordinatedCell, Cell.T == T, UCell: ConfigurableCell, UCell.T == U {
    
    //inject datasource
    var containerControllerModel: ContainerControllerModel!
    var containerControllerDataSource: [T]!
    
    var tableViewDatasource: [U]!
    
    var coordinator: AnyObject?
    
    //TODO: replace custom header with a generic custom header type
    let sectionHeaderId = "sectionHeader"
    
    public init(model: ContainerControllerModel, collectionDatasource: [T], datasource: [U], coordinator: AnyObject?) {
        super.init(style: .grouped)
        self.containerControllerModel = model
        self.containerControllerDataSource = collectionDatasource
        self.tableViewDatasource = datasource
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        navigationItem.title = containerControllerModel.navigationItemTitle
        //tableView.register(ContainerCell.self, forCellReuseIdentifier: containerCellId)
        tableView.register(BaseContainerCell<T, Cell, U, UCell>.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.register(UCell.self, forCellReuseIdentifier: UCell.reuseIdentifier)
        
        //TODO: replace custom header with a generic custom header type
        // Register the custom header view.
        tableView.register(MoreButtonCustomHeader.self,
                           forHeaderFooterViewReuseIdentifier: sectionHeaderId)
        
        tableView.separatorStyle = .none
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    // Create a standard header that includes the returned text.
    /*
     override func tableView(_ tableView: UITableView, titleForHeaderInSection
     section: Int) -> String? {
     return containerControllerModel.sectionTitles[section]
     //return "Header \(section)"
     }
     */
    
    public override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as? MoreButtonCustomHeader else { return nil }
        
        switch section {
        case 0:
            view.title.text = containerControllerModel.sectionTitles[section]
            view.title.textColor = UIColor(hexString: containerControllerModel.sectionTitleHexColor)
            //view.image.image = UIImage(named: sectionImages[section])
            view.more.isHidden = true
        case 1:
            view.title.text = containerControllerModel.sectionTitles[section]
            //view.image.image = UIImage(named: sectionImages[section])
            view.title.textColor = UIColor(hexString: containerControllerModel.sectionTitleHexColor)
            view.more.setTitle(containerControllerModel.sectionMoreButtonTitles[section], for: .normal)
            view.more.setTitleColor( UIColor(hexString: containerControllerModel.sectionMoreButtonTitleHexColor), for: .normal)
            view.more.sizeToFit()
        default:
            break
        }
        
        return view
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return tableViewDatasource.count
        default:
            return 0
        }
    }
        
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //collectionview cells container
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath)
            if let cell = cell as? BaseContainerCell<T, Cell, U, UCell> {
                var cellModel = BaseContainerCellModel() //TODO: inject the basecontainer cell model
                cellModel.backgroundColor = UIColor(hexFromString: "#F6F6F6")
                cell.datasource = containerControllerDataSource
                cell.coordinator = coordinator
                cell.model = cellModel
                cell.containerController = self
                
            }
            return cell
        } else {
            //tableview cell
            let cell = tableView.dequeueReusableCell(withIdentifier: UCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? UCell {
                cell.configure(tableViewDatasource[indexPath.row], at: indexPath)
            }
            return cell
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return containerControllerModel.collectionRowHeight//400
        } else {
            return containerControllerModel.tableRowHeight
        }
    }
}
