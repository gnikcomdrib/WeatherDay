import Foundation
import SwiftUI

// Extensão para validar se a string representa um email válido
extension String{
    func isValidEmail() -> Bool {
        // Validar o formato de um email
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        // Verifica se a string corresponde ao formato de um email
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
}
// Extensão para arredondar um número decimal em uma string
extension Double{
    func roundDouble() -> String{
        return String(format: "%.0f", self)
    }
}
// Extensão para aplixar cantos arredondados
extension View{
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
struct RoundedCorner: Shape{
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
