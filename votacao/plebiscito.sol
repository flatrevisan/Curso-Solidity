/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.6.11;

contract Plebicito {
  
  mapping(address => bool) public eleitores;
  uint256 public totalDeEleitores;
  address public secretario;
  string public materia;
  string public opcao1;
  string public opcao2;
  uint256 public votosOpcao1;
  uint256 public votosOpcao2;

  event VotoComputado(address eleitor);

  constructor(
    string memory _materia,
    address _secretario,
    string memory _opcao1,
    string memory _opcao2
  ) public {
    materia = _materia;
    secretario = _secretario;
    opcao1 = _opcao1;
    opcao2 = _opcao2;
    registraEleitor(0x4552af37231ac1B91281bC5268340c1B4cf0207A);
    registraEleitor(0x3D81c1a50F8607c86db4fb1a6f530358a6Fc3D4d);
    registraEleitor(0xF87404b20AB2c0D08d83DB3740Da234d35872c65);
    registraEleitor(0x888cDa7b74D2364FfBA6c27FeFF2237501B85DF6);
    registraEleitor(0xe3aa4714c07C7e0Bc8bf41C7F1B05B5773Cc8434);
    registraEleitor(0x6423Cc6319c2CD3f0a313290a9B15120BFB83E65);
    registraEleitor(0xA1d9EB502f7fd47c4AcEd2190823AdEE300e444F);
    registraEleitor(0xc968c7fe97B63D108Bf7C04b371BA7a738223f55);
    registraEleitor(0xAa0BadFFD8ab151807D61D0420b4383f8700018b);
  }

  function registraEleitor(address _eleitor) public returns (bool) {
    require(msg.sender == secretario, "Somente secretario pode registrar o eleitor");
    eleitores[_eleitor] = true;
    totalDeEleitores = totalDeEleitores + 1;
    return true;
  }

  function impugnaEleitor(address _eleitor) public returns (bool) {
    require(msg.sender == secretario, "Somente secretario pode impugnar o eleitor");
    require(eleitores[_eleitor] == true, "Eleitor apto nao encontrado");
    eleitores[_eleitor] = false;
    totalDeEleitores = totalDeEleitores - 1;
    return true;
  }

  function votar(uint256 opcao) public returns (bool) {
    require(eleitores[msg.sender] == true, "Voce nao eh um eleitor registrado");
    if (opcao == 1) {
      votosOpcao1 = votosOpcao1 + 1;
    } else if (opcao == 2) {
      votosOpcao2 = votosOpcao2 + 1;
    }
    emit VotoComputado(msg.sender);
    return true;
  }
  

}
