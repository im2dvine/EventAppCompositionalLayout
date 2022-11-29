import UIKit

class HomeViewController: UIViewController {

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, enviroment) ->
            NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[sectionIndex].type
            
            switch sectionType {
            case .featured:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(230))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(204), heightDimension: .absolute(230))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 5, trailing: 0)
                
                return section
                
                
            default: return nil
            }
        }
        
        
        return layout
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    func initialize() {
        setUpCollectionView()
        configureDataSource()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "FeaturedViewCell", bundle: .main), forCellWithReuseIdentifier: "FeaturedViewCell")
        collectionView.register(UINib(nibName: "RecommendedViewCell", bundle: .main), forCellWithReuseIdentifier: "RecommendedViewCell")
        collectionView.register(UINib(nibName: "LatestViewCell", bundle: .main), forCellWithReuseIdentifier: "LatestViewCell")
        collectionView.register(UINib(nibName: "CategoriesViewCell", bundle: .main), forCellWithReuseIdentifier: "CategoriesViewCell")
        
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            
            let  snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case .featured:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedViewCell", for: indexPath)
                return cell
          
                
            default: return nil
                
            }
            
        }
        
        let sections = [
            Section(type: .featured, items: [
                Item(), Item(), Item()
            ])
        ]
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }

}

