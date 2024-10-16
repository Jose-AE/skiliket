//
//  NewsViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 10/10/24.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newsList: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Llamada para cargar los datos del JSON desde la URL
        loadNewsData(from: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo10/news.json")
    }

    // MARK: - UICollectionView DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
        
        let newsItem = newsList[indexPath.row]
        cell.titleLabel.text = newsItem.title
        cell.descriptionLabel.text = newsItem.description
        
        if let imageUrl = URL(string: newsItem.imageUrl) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }

        return cell
    }

    // MARK: - Función para cargar los datos desde la URL
    func loadNewsData(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedNews = try JSONDecoder().decode([String: [News]].self, from: data)
                DispatchQueue.main.async {
                    self.newsList = decodedNews["news"] ?? []
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }.resume()
    }
}
