import Foundation

//// Первая часть задания
func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Это ошибка\n\(error ?? fatalError()) (Задание *)")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print("""
                  Это код ответа(Задание *)
                  ---------------------------
                  \(response)
                  Это пришедшие данные (Задание *)
                  ---------------------------
                  \(dataAsString ?? "данные отсутствуют")
                  ---------------------------
                  """)
        }
    }.resume()
}

getData(urlRequest: "https://cat-fact.herokupp.com")

//Дополнительная часть задания
func getURL() -> URL? {
    var components = URLComponents()
    let marvelValues = MarvelURLValues()
    
    components.scheme = marvelValues.scheme
    components.host = marvelValues.host
    components.path = marvelValues.path
    
    let timeStampQuery = URLQueryItem(name: marvelValues.timeStamp.name,
                                      value: marvelValues.timeStamp.value)
    let apikeyQuery = URLQueryItem(name: marvelValues.apiKey.name,
                                   value: marvelValues.apiKey.value)
    let hashQuery = URLQueryItem(name: marvelValues.hash.name,
                                 value: marvelValues.hash.value)
    
    components.queryItems = [timeStampQuery, apikeyQuery, hashQuery]
    
    return components.url
}

func getMarvelData(urlRequest: URL?) {
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Это ошибка\n\(error ?? fatalError())")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print("""
                  Это код ответа
                  ---------------------------
                  \(response)
                  Это пришедшие данные
                  ---------------------------
                  \(dataAsString ?? "данные отсутствуют")
                  ---------------------------
                  """)
        }
    }.resume()
}

let URLValue = getURL()
getMarvelData(urlRequest: URLValue)

