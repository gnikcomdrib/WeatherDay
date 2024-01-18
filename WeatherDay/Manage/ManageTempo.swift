import Foundation
import CoreLocation

// Classe que gerencia as requisições de clima
class ManageTempo{
    // Função assíncrona para obter as condições climáticas atuais com base na latitude e longitude obtidas
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody{
        // Constrói um URL com base na latitude e longitude com a API
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("API KEY")&units=metric") else { fatalError("Missing URL")}
        
        // Criar request ao URL
        let urlRequest = URLRequest(url: url)
        
        // Faz um request assíncrono com URLSession para obter os dados do clima
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Verifica se a resposta ao request foi bem sucedida (status code 200)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError( "Error getting weeather data")}
        
        // Decodifica os dados obtidos em um objeto do tipo ResponseBody ao usar JSONDecoder
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        // Retorna os dados climáticos decodificados
        return decodedData
    }
}

// Estrutura que representa a resposta ao request do clima (ResponseBody)
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    // Estrutura que representa as coordenadas geográficas
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    // Estrutura que representa os detalhes climáticos
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    // Estrutura que representa os restantes dados climáticos
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    // Estrutura que representa os detalhes do vento
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

// Extensão para ResponseBody.MainResponse para fornecer propriedades com nomes mais legíveis
extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
