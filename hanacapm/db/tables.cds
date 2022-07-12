//namespace db;

context db {

    entity pessoa {
        key cpf          : String(11);
            nome         : String(50);
            dtnascimento : Date;
            cidade       : String(50);
    }

    entity bens {
        key serial      : String(20);
        key cpf         : String(11);
            nome        : String(50);
            marca       : String(40);
            informacoes : String(200);
            dtcompra    : Date;
            valor       : Decimal(13, 2);
    }

    entity log {
        key number : Integer;
            nameUser   : String(200);
            dtLog  : String;
            method : String;
            entity : String;
    }

    entity v_relatorio as
        select from pessoa
        left outer join bens
            on pessoa.cpf = bens.cpf
        {
            key pessoa.cpf,
                pessoa.nome,
                pessoa.dtnascimento,
                pessoa.cidade,
            key bens.serial,
                bens.nome as prdNome,
                bens.marca,
                bens.informacoes,
                bens.dtcompra,
                bens.valor
        };

}


@cds.persistence.calcview
@cds.persistence.exists
entity![V_PESSOAS_BENS]{
    key![CPF]          : String(11)     @title : 'CPF: CPF';
    key![NOME]         : String(50)     @title : 'NOME: NOME';
    key![CIDADE]       : String(50)     @title : 'CIDADE: CIDADE';
    key![DTNASCIMENTO] : Date           @title : 'DTNASCIMENTO: DTNASCIMENTO';
    key![IDADE]        : String(13)     @title : 'IDADE: IDADE';
    key![SERIAL]       : String(20)     @title : 'SERIAL: SERIAL';
    key![NOME_1]       : String(50)     @title : 'NOME_1: NOME';
    key![MARCA]        : String(40)     @title : 'MARCA: MARCA';
    key![INFORMACOES]  : String(200)    @title : 'INFORMACOES: INFORMACOES';
    key![DTCOMPRA]     : Date           @title : 'DTCOMPRA: DTCOMPRA';
    key![VALOR]        : Decimal(13, 2) @title : 'VALOR: VALOR';
}
