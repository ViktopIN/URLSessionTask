import Foundation

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
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
                  """)
        }
    }.resume()
}

getData(urlRequest: "https://cat-fact.herokuapp.com")
