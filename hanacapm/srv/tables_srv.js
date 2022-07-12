const cds = require('@sap/cds');

module.exports = cds.service.impl( async function() {

    //Objeto de comunicação com o Banco HANA
    const srv = await cds.connect.to('db');

    const getData = () => {
        let oDate = new Date();
        let day = oDate.getDate().toString().length > 1 ? oDate.getDate() : `0${oDate.getDate()}`;
        let month = (oDate.getMonth()+1).length > 1 ? oDate.getMonth() + 1 : `0${oDate.getMonth()+1}`;
        let year = oDate.getFullYear();

        return `${day}.${month}.${year}`
    }

    const createLog = async (req, method, entity) => {
        try{   
            const logs = await srv.read('db.log');
            await srv.create('db.log',{
                "NUMBER" : logs.length + 1,
                "NAMEUSER" : req.user.id,
                "DTLOG" : getData(),
                "METHOD" : method,
                "ENTITY" : entity
            });
            return 200;
        }catch (err){
            return {message : err, status : 400};
        }
    }

    this.on('READ', 'Pessoas', async req =>{

        const res = await srv.read('db.pessoa');

        const log = await createLog(req, 'READ', 'Pessoas');

        if( log === 200){
            req.reply(res);
        }else{
            req.reply({message : log.message, status : log.status});
        }
    });

    this.on("READ", 'V_pessoas_bens', async req => {
        
        const res = await srv.read('V_PESSOAS_BENS');
        const log = await createLog(req, "READ", "V_pessoas_bens");
        if( log === 200){
            req.reply(res);
        }else{
            req.reply({message : log.message, status : log.status});
        }
    })
});