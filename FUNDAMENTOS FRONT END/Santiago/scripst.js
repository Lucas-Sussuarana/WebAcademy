let selectTema = document.querySelector('select#tema');
selectTema.addEventListener('change', 
evento => {
    let temaselecionado = evento.target.value;
    //console.log(temaselecionado)

    if (temaselecionado){
        mudaTema(temaselecionado);
        localStorage.setItem('tema', temaselecionado)
    }
})

const mudaTema = (temaselecionado) => {
    linkTema = document.querySelector('#linkTema');
    let url = "/css/" + temaselecionado + '.css';
    linkTema.href = url;
    imglogo = document.querySelector('#imglogo');
    console.log(temaselecionado)
    if(temaselecionado == 'amarelo' || temaselecionado == 'vermelho'){
        imglogo.src = "/imagens/logo_branco(64).png"
    }
    else{
        imglogo.src = "/imagens/logo_azul(64).png"
    }
}

let tema = localStorage.getItem('tema');
if (tema) {
    mudaTema(tema)
}

const carregaTabela = () => {
    //let url = 'http://my-json-server.typicode.com/juniorlimeiras/json/profissionais';
    let url = '/json/tabela.json'
    let xhr = new XMLHttpRequest();
    xhr.open('GET', url);
    let tabela = document.querySelector('table');
    xhr.addEventListener('readystatechange', () => {
        if (xhr.readyState == 4 && xhr.status == 200) {
            let dados = JSON.parse(xhr.responseText);
            for (const item of dados) {
                let linha = document.createElement('tr');
                let id = document.createElement('td');
                let nome = document.createElement('td');
                let conselho = document.createElement('td');
                let email = document.createElement('td');
                let telefone = document.createElement('td');
                let unidade = document.createElement('td');
                let especialidade = document.createElement('td');
                let acoes = document.createElement('td');

                id.textContent = item.id;
                nome.textContent = item.nome;
                conselho.textContent = item.registro;
                email.textContent = item.email;
                telefone.textContent = item.telefone;
                unidade.textContent = item.unidade;
                especialidade.textContent = item.especialidade;
                acoes.innerHTML = ` <a class="editar">Editar</a>
                                    <a class="excluir">Excluir</a>`;
                linha.appendChild(id);
                linha.appendChild(nome);
                linha.appendChild(conselho);
                linha.appendChild(email);
                linha.appendChild(telefone);
                linha.appendChild(unidade);
                linha.appendChild(especialidade);
                linha.appendChild(acoes);
                tabela.tBodies[0].appendChild(linha)

                let botaoExcluir = linha.querySelector('.excluir');
                botaoExcluir.addEventListener('click', () => {
                    linha.remove();
                })
            }
        }
    })
    xhr.send();
}

carregaTabela();
