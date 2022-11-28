import UIKit

class DetailViewController: UIViewController {
    
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
            case .article:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(240))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                
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
        collectionView.register(UINib(nibName: "ArticleViewCell", bundle: .main), forCellWithReuseIdentifier: "ArticleViewCell")
        collectionView.register(UINib(nibName: "RecommendationsViewCell", bundle: .main), forCellWithReuseIdentifier: "RecommendationsViewCell")
        collectionView.register(UINib(nibName: "MeetingViewCell", bundle: .main), forCellWithReuseIdentifier: "MeetingViewCell")
        collectionView.register(UINib(nibName: "AboutViewCell", bundle: .main), forCellWithReuseIdentifier: "AboutViewCell")
        collectionView.register(UINib(nibName: "SimilarViewCell", bundle: .main), forCellWithReuseIdentifier: "SimilarViewCell")
        
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            
            let  snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case .article:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleViewCell", for: indexPath)
                return cell
          
                
            default: return nil
                
            }
            
        }
        
        let sections = [
            Section(type: .article, items: [
                Item()
            ])
        ]
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}
