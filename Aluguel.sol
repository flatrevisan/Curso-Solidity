// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

contract Aluguel {
    
    string public locador;
    string public locatario;
    uint256 private valor;
    uint256 constant numeroMaximoLegalDeAlugueisParaMulta = 3;
    
    constructor ( 
        string memory paramLocador,
        string memory _Locatario,
        uint256 valorDoAluguel
    )
public
{
    locador = paramLocador;
    locatario = _Locatario;
    valor = valorDoAluguel;
    }
}
