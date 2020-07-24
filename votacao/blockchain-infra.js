//Definicoes de variaveis para toda a pagina (ou site)
//Variaveis essas relacionadas a operações com Metamask e Contratos Inteligentes no Ethereum
var contaAtual;
var provedorDeSignatarios;
var signatario;
var contratoComSignatario;

/*
FUNCOES RELACIONADAS A OPERACOES COM METAMASK E CONTRATOS INTELIGENTES NO ETHEREUM
*/
function conectaAoMetamask() {
  event.preventDefault();
  console.log("conectaAoMetamask chamado");
  if (typeof window.ethereum === "undefined") {
    alert("Por favor instale o MetaMask em metamask.io");
    return;
  } else {
    requisitaAcessoAContas();
  }
}

function requisitaAcessoAContas() {
  ethereum
    .send("eth_requestAccounts")
    .then(gerenciaTrocaDeSelecaoDeContas)
    .catch((err) => {
      if (err.code === 4001) {
        // EIP 1193 userRejectedRequest error
        console.log("Por favor, dê permissão a este site no seu Metamask.");
      } else {
        console.error(err);
      }
    });
  ethereum.on("accountsChanged", gerenciaTrocaDeSelecaoDeContas);
}

function gerenciaTrocaDeSelecaoDeContas(_contas) {
  if (typeof provedorDeSignatarios === "undefined") {
    provedorDeSignatarios = new ethers.providers.Web3Provider(web3.currentProvider);
  }
  var contas;
  if (typeof _contas.result === "undefined") {
    contas = _contas;
  } else {
    contas = _contas.result;
  }
  console.log("gerenciaTrocaDeSelecaoDeEndereco - parametro recebido", contas);
  if (contas.length === 0) {
    alert("Por favor instale o MetaMask em metamask.io ou o autorize a acessar a sua conta");
    return;
  }
  if (contas[0] !== contaAtual) {
    contaAtual = contas[0];
    if (contaAtual) {
      $("#btnOpcao1").prop("disabled", false);
      $("#btnOpcao2").prop("disabled", false);
    }
  }
  signatario = provedorDeSignatarios.getSigner();
  contratoComSignatario = new ethers.Contract(enderecoContrato, abiContrato, signatario);
  buscarDadosDoContratoInteligente();
}

function buscarDadosDoContratoInteligente() {
  contratoComSignatario
    .materia()
    .then((resultado) => {
      console.log("O conteudo retornado foi ", resultado);
      $("#materiaDeVotacao").html(resultado);
    })
    .catch((err) => {
      console.error("Houve um erro ", err);
    });
  contratoComSignatario
    .opcao1()
    .then((resultado) => {
      console.log("O conteudo retornado foi ", resultado);
      $("#descricaoOpcao1").html(resultado);
      $("#btnOpcao1").html(resultado);
    })
    .catch((err) => {
      console.error("Houve um erro ", err);
    });
  contratoComSignatario
    .votosOpcao1()
    .then((resultado) => {
      console.log("O conteudo retornado foi ", resultado.toNumber());
      $("#exibicaoVotosOpcao1").html(resultado.toNumber());
    })
    .catch((err) => {
      console.error("Houve um erro ", err);
    });
  contratoComSignatario
    .opcao2()
    .then((resultado) => {
      console.log("O conteudo retornado foi ", resultado);
      $("#descricaoOpcao2").html(resultado);
      $("#btnOpcao2").html(resultado);
    })
    .catch((err) => {
      console.error("Houve um erro ", err);
    });
  contratoComSignatario
    .votosOpcao2()
    .then((resultado) => {
      console.log("O conteudo retornado foi ", resultado.toNumber());
      $("#exibicaoVotosOpcao2").html(resultado.toNumber());
    })
    .catch((err) => {
      console.error("Houve um erro ", err);
    });
  $("#informacoes").show();
  $("#votacao").show();
  $("#tituloPlebiscito").show();
  $("#btnConectaMetamask").hide();
}

function enviaVoto(_opcaoDesejada) {
  $("#descricaoStatusTransacoes").html("Transação enviada. Aguarde pela mineração...");
  $("#statusTransacoes").show();
  contratoComSignatario
    .votar(_opcaoDesejada)
    .then((transacao) => {
      transacao
        .wait()
        .then((resultado) => {
          console.log("enviaVoto - o resultado foi ", resultado);
          if (resultado.status === 1) {
            $("#descricaoStatusTransacoes").html("Voto computado. Obrigado.");
            $("#btnOpcao1").prop("disabled", true);
            $("#btnOpcao2").prop("disabled", true);
          } else {
            $("#descricaoStatusTransacoes").html("Houve um erro no voto: " + resultado);
          }
        })
        .catch((err) => {
          console.error("enviaVoto - a transação foi minerada e houve um erro. Veja abaixo");
          console.error(err);
          $("#descricaoStatusTransacoes").html("Algo saiu errado: " + err.message);
        });
    })
    .catch((err) => {
      console.error("enviaVoto - tx só foi enviada");
      console.error(err);
      $("#descricaoStatusTransacoes").html("Algo saiu errado antes de enviar ao Ethereum: " + err.message);
    });
}
