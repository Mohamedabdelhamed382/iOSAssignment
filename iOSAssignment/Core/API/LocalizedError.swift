//
//  LocalizedError.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Foundation

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "لا يوجد اتصال بالإنترنت"
        case .invalidURL:
            return "الرابط غير صالح"
        case .decodingError:
            return "فشل في تحليل البيانات"
        case .serverError(let code):
            return "خطأ في الخادم. الرمز: \(code)"
        case .unknown(let err):
            return "حدث خطأ غير معروف: \(err.localizedDescription)"
        }
    }
}
