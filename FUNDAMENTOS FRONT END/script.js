let selectTema = document.querySelector('select#tema');
selectTema.addEventListener('change' , evento => {
    let temaselecionado = evento.target.value;
    if(temaselecionado){
        mudaTema(temaselecionado);
    }
});

const mudaTema = (temaselecionado) => {
    let linkTema = document.querySelector('#link-tema');
    let url = "css/estilo-tema-"+temaselecionado+".css";
    linkTema.href = url;
}
lettema = localStorage.getItem('tema');
if (tema) {
    mudaTema(tema);
}
carregarProfissionais = () => {
    let url = 'http://my-json-server.typicode.com/juniorlimeiras/json/profissionais'
    let xhr = new XMLHttpRequest();
    xhr.open('GET' , url);
    let tabela= document.querySelector('table');
    xhr.addEventListener('readystatechange', () => {
        if(xhr.readyState === 4 && xhr.status === 200){
            dados = JSON.parse (xhr.responseText);
           //console.log(dados);
           for (const item of dados){
            //cRIANDO ELEMENTOS HTML DA TABLE
            let linha = document.createElement('tr');
            let id = document.createElement('td');
            let nome = document.createElement('td');
            let registerConselho = document.createElement('td');
            let email = document.createElement('td');
            let telefone = document.createElement('td');
            let unidade = document.createElement('td');
            let especialidade = document.createElement('td');
            let acoes = document.createElement('td');
            //ELEMENTOS
            id.textContent = item.id;
            nome.textContent = item.nome;
            registerConselho.textContent = item.registro;
            email.textContent = item.email;
            telefone.textContent = item.telefone;
            unidade.textContent = item.unidade;
            especialidade.textContent = item.especialidade;
            acoes.innerHTML = '<a class="botao" href="javascript:void(0)">Editar</a> <a id="vermelho" class="botao" href="javascript:void(0)">Excluir</a>';
            //PREENCHER A LINHA
            linha.appendChild(id);
            linha.appendChild(nome);
            linha.appendChild(registerConselho);
            linha.appendChild(email);
            linha.appendChild(telefone);
            linha.appendChild(unidade);
            linha.appendChild(especialidade);
            linha.appendChild(acoes);
            //PREENCHIMENTODA TABELA
            tabela.tBodies[0].appendChild(linha);
           }
        }
    });
    xhr.send();
};
carregarProfissionais();

//FUNÇÃO PRA EXCLUIR PROFISSIONAL
let botaoExcluir = document.querySelector('a.botao#vermelho');
for (const bt of botoes){
    botaoExcluir.addEventListener('click',() =>{
        bt.remove();
    });
}