//
//  HTTPResponseDTO.swift
//  EntainTechnicalTask
//
//  Created by Brett Best on 30/10/2023.
//  Copyright © 2023 Entain Group Pty Ltd. All rights reserved.
//

import Tagged

struct HTTPResponseDTO<DTO: Decodable>: Decodable {
  typealias StatusCode = Tagged<Self, UInt16>

  let status: StatusCode
  let data: DTO
  let message: String
}
