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
    function valorDoAluguel () public view returns (uint256) {
        return valor;
    }
    
    function simulaMulta (uint256 mesesRestantes, uint256 totalMesesContrato) public view returns (uint256 valorMulta)
    {
        valorMulta = valor*numeroMaximoLegalDeAlugueisParaMulta;
        valorMulta = valor/totalMesesContrato;
        valorMulta = valorMulta*mesesRestantes;
        return valorMulta;
    }

    function reajusteAluguel (uint256 percentualReajuste) public
    {
        if (percentualReajuste > 20)
        {
            percentualReajuste = 20;
        }
        uint256 valorDoAcrescimo = 0;
        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
}
