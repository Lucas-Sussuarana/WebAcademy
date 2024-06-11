// let botao = document.querySelector('a#add');
// botao.addEventListener('click', () => {alert('Cliclado')});
// botao.addEventListener('click', funcaoA);
// botao.addEventListener('click', funcaoA);
// function funcaoA() {
//     alert('A');
// }
// function funcaoB() {
//     alert('B');
// }

let selectTema = document.querySelector('select#tema')
selectTema.addEventListener('change', evento => {
    let temaSelecionado = evento.target.value;
    // console.log(temaSelecionado);
    if(temaSelecionado){mudaTema(temaSelecionado);}
    
    localStorage.setItem('tema', temaSelecionado)
});

const mudaTema = (temaSelecionado) => {
    let linkTema = document.querySelector('#link-tema');
    let url = "/css/estilo-tema-"+temaSelecionado+".css";
    linkTema.href = url;
}

let tema = localStorage.getItem('tema');
if(tema){
    mudaTema(tema);
}

// const carregarProfissionais = () =>{
//     let url = "http://my-json-server.typicode.com/juniorlimeiras/json/profissionais";
//     let xhr = new XMLHttpRequest();
//     xhr.open('GET', url);
//     let tabela = document.querySelector('table');
//     xhr.addEventListener('readystatechange', () => {
//         if(xhr.readyState === 4 && xhr.status === 200){
//             dados = JSON.parse(xhr.responseText);
//             // console.log(dados);
//             for (const item of dados){
//                 //criando os elementos html
//                 let linha = document.createElement('tr');
//                 let id = document.createElement('td');
//                 let registroConselho = document.createElement('td');
//                 let telefone = document.createElement('td');
//                 let email = document.createElement('td');
//                 let unidade = document.createElement('td');
//                 let especialidade = document.createElement('td');
//                 let acoes = document.createElement('td');
//                 //preencher os elementos
//                 id.textContent = item.id
//                 nome.textContent = item.nome
//                 registroConselho.textContent = item.registro
//                 email.textContent = item.email
//                 telefone.textContent = item.telefone
//                 unidade.textContent = item.unidade
//                 especialidade.textContent = item.especialidade
//                 acoes.innerHTML = '<a class="botao" href="javascript:void(0)">Editar</a> <a id="vermelho" class="botao" href="javascript:void(0)">Excluir</a>';
//                 //PREENCHER A LINHA
//                 linha.appendChild(id);
//                 linha.appendChild(nome);
//                 linha.appendChild(registroConselho);
//                 linha.appendChild(telefone);
//                 linha.appendChild(email);
//                 linha.appendChild(unidade);
//                 linha.appendChild(especialidade);
//                 linha.appendChild(acoes);
//                 //Preencher a tabela com uma linha
//                 tabela.tBodies[0].appendChild(linha);
//             }

//         }
//     });
//     xhr.send();
// };

// const carregarProfissionais = () =>{
//     let url = "https://my-json-server.typicode.com/juniorlimeiras/json/profissionais";
//     let xhr = new XMLHttpRequest();
//     xhr.open('GET', url);
//     let tabela = document.querySelector('table');
//     xhr.addEventListener('readystatechange', () => {
//         if(xhr.readyState === 4 && xhr.status === 200){
//             let dados = JSON.parse(xhr.responseText);
//             // console.log(dados);
//             for(const item of dados){
//                 //Criando as colunas da página profissionais
//                 let linha = document.createElement('tr');
//                 let id= document.createElement('td');
//                 let nome = document.createElement('td');
//                 let registroConselho = document.createElement('td');
//                 let email = document.createElement('td');
//                 let telefone = document.createElement('td');
//                 let unidade = document.createElement('td');
//                 let especialidade = document.createElement('td');
//                 let acoes = document.createElement('td');
//                 //preenchendo os elementos
//                 id.textContent = item.id
//                 nome.textContent = item.nome
//                 registroConselho.textContent = item.registro
//                 email.textContent = item.email
//                 telefone.textContent = item.telefone
//                 unidade.textContent = item.unidade
//                 especialidade.textContent = item.especialidade
//                 acoes.innerHTML = '<a class="botao" href="javascript:void(0)">Editar</a> <a id="vermelho" class="botao" href="javascript:void(0)">Excluir</a>';
//                 //Preenchendo a linha agora kkkk :)
//                 linha.appendChild(id);
//                 linha.appendChild(nome);
//                 linha.appendChild(registroConselho);
//                 linha.appendChild(email);
//                 linha.appendChild(telefone);
//                 linha.appendChild(unidade);
//                 linha.appendChild(especialidade);
//                 linha.appendChild(acoes);
//                 //Preenchendo a tabela com uma linha da tabela
//                 tabela.tBodies[0].appendChild(linha);
//         }
//     }
//     });
//     xhr.send();    
// };
// carregarProfissionais();
const carregarProfissionais = () => {
    let url = "https://my-json-server.typicode.com/juniorlimeiras/json/profissionais";
    let tabela = document.querySelector('table');
    fetch(url).then(resposta =>{
        return resposta.json();
    }).then(dados => {
        for (const item of dados){
                inserirProffisional(item);

        }
        eventoExcluir();
    }).catch(erro => {
        console.error(error)
    })
//    let xhr = new XMLHttpRequest();
//     xhr.open('GET', url);
//     let tabela = document.querySelector('table');
//     xhr.addEventListener('readystatechange', () => {
//         if (xhr.readyState === 4 && xhr.status === 200) {
//             let dados = JSON.parse(xhr.responseText);
//             for (const item of dados) {
//                 let linha = document.createElement('tr');
//                 let id = document.createElement('td');
//                 let nome = document.createElement('td');
//                 let registroConselho = document.createElement('td');
//                 let email = document.createElement('td');
//                 let telefone = document.createElement('td');
//                 let unidade = document.createElement('td');
//                 let especialidade = document.createElement('td');
//                 let acoes = document.createElement('td');

//                 id.textContent = item.id;
//                 nome.textContent = item.nome;
//                 registroConselho.textContent = item.registro;
//                 email.textContent = item.email;
//                 telefone.textContent = item.telefone;
//                 unidade.textContent = item.unidade;
//                 especialidade.textContent = item.especialidade;
//                 acoes.innerHTML = '<a class="botao" href="javascript:void(0)">Editar</a> <a class="botao vermelho" id="vermelho" href="javascript:void(0)">Excluir</a>';

//                 linha.appendChild(id);
//                 linha.appendChild(nome);
//                 linha.appendChild(registroConselho);
//                 linha.appendChild(email);
//                 linha.appendChild(telefone);
//                 linha.appendChild(unidade);
//                 linha.appendChild(especialidade);
//                 linha.appendChild(acoes);

//                 tabela.tBodies[0].appendChild(linha);

//                 // > Adiciona evento de clique ao botão de exclusão
//                 let botaoExcluir = linha.querySelector('a.vermelho');
//                 botaoExcluir.addEventListener('click', () => {
//                     linha.remove(); // < Remove a linha da tabela
//                 });
//             }
//         }
//     });
//     xhr.send();
};

carregarProfissionais();
let botoesExcluir = document.querySelectorAll('a.botao#vermelho');
// > Adiciona um evento de clique para cada botão
botoesExcluir.forEach(botao => {
    botao.addEventListener('click', () => {
        // > Remove o pai do botão (a linha da tabela)
        botao.parentNode.parentNode.remove();
    });
});

let botaoadicionar = document.querySelector('a.botao#add');
let form = document.querySelector('form');
let botaoCancelar = document.querySelector('input#vermelho');

botaoadicionar.addEventListener('click', () => {
    form.classList.remove('inativo');
});
botaoCancelar.addEventListener('click', () => {
    form.classList.add('inativo');
    form.reset();
})

let tabela = document.querySelector('table');
//adicionar um fucionamento para enviar os dados do form a tabela
form.addEventListener('submit', (evento) =>{
    evento.preventDefault();
    let profissionais = {
        id: tabela.tBodies[0].rows.length + 1,
        nome: form.nome.value,
        registro: form.registro.value,
        telefone: form.telefone.value,
        email: form.email.value,
        unidade: form.unidade.options[form.unidade.selectedIndex].label,
        especialidade: form.especialidade.options[form.especialidade.selectedIndex].label
    };
    inserirProffisional(profissionais);

});
//funçao que insere um objeto profissional na tabela html
const inserirProffisional = (item) => {
            let linha = document.createElement('tr');
            let id = document.createElement('td');
            let nome = document.createElement('td');
            let registro = document.createElement('td');
            let email = document.createElement('td');
            let telefone = document.createElement('td');
            let unidade = document.createElement('td');
            let especialidade = document.createElement('td');
            let acoes = document.createElement('td');

            id.textContent = item.id;
            nome.textContent = item.nome;
            registro.textContent = item.registro;
            email.textContent = item.email;
            telefone.textContent = item.telefone;
            unidade.textContent = item.unidade;
            especialidade.textContent = item.especialidade;
            acoes.innerHTML = '<a class="botao" href="javascript:void(0)">Editar</a> <a class="botao vermelho" id="vermelho" href="javascript:void(0)">Excluir</a>';

            linha.appendChild(id);
            linha.appendChild(nome);
            linha.appendChild(registro);
            linha.appendChild(email);
            linha.appendChild(telefone);
            linha.appendChild(unidade);
            linha.appendChild(especialidade);
            linha.appendChild(acoes);

            tabela.tBodies[0].appendChild(linha);

}

