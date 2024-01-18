import Foundation

/**
 Carrega um arquivo JSON a partir do bundle principal e o decodifica em um tipo genérico.
 
 - Parameter filename: O nome do arquivo JSON a ser carregado.
 - Returns: Um tipo genérico decodificado a partir do JSON.
 - Important: Certifique-se de que o arquivo JSON e sua estrutura correspondem ao tipo decodificado.
 - Warning: Este método usa 'fatalError' para encerrar o aplicativo em caso de falha ao carregar ou decodificar o arquivo JSON.
 */

var previewTempo: ResponseBody = load("Data.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    // Verifica se o Data.json se encontra no bundle principal
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Não foi encontrado \(filename) no main bundle.")
    }

    do {
        // Lê os dados do ficheiro JSON
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Não foi carregado \(filename) no main bundle:\n\(error)")
    }

    do {
        // Decodifica os dados do ficheiro JSON para o tipo genérico especificado
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Não foi possível analisar \(filename) como \(T.self):\n\(error)")
    }
}
