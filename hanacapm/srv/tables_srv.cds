using db from '../db/tables';
using V_PESSOAS_BENS from '../db/tables';

service MyService @(requires : 'authenticated-user') {
    entity Pessoas @(restrict : [{ grant : [ 'CREATE',
                                             'READ',
                                             'UPDATE',
                                             'DELETE'],
                                    to : 'authenticated-user'}]) as projection on db.pessoa;
    entity Bens @(restrict : [{ grant : ['CREATE',
                                         'UPDATE',
                                         'READ',
                                         'DELETE'],
                                to : 'authenticated-user'}]) as projection on db.bens;

    entity Logs @(restrict : [{ grant : ['CREATE',
                                         'UPDATE',
                                         'READ',
                                         'DELETE'],
                                to : 'authenticated-user'}]) as projection on db.log;
    
    @readonly
    entity V_RELATORIO @(restrict : [{ grant : ['READ'],
                                       to : 'authenticated-user'}]) as projection on db.v_relatorio;
    @readonly
    entity V_pessoas_bens @(restrict : [{ grant : ['READ'],
                                       to : 'authenticated-user'}]) as projection on V_PESSOAS_BENS
    }
