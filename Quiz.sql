show tables;

describe pago;

select * from pago;
select * from cliente;

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values ('ak-std-000027', 4, 'Paypal', sysdate(), 5000);

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
values ('ak-std-000028', 4, 'Paypal', sysdate(), 300);

/*********************************************/
DELIMITER //
CREATE PROCEDURE SP_INSERTAR_PAGO ( IN p_id_transaccion VARCHAR(50), IN p_codigo_cliente INT,
IN p_forma_pago VARCHAR(40), IN p_fecha_pago DATE, IN p_total INT)

BEGIN  
DECLARE v_existe_id_tran  varchar(50);


SELECT COUNT(*)
INTO v_existe_id_tran
FROM PAGO WHERE id_transaccion = p_id_transaccion;

IF v_existe_id_tran = 0 THEN
	insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total)
    values (p_id_transaccion, p_codigo_cliente, p_forma_pago, p_fecha_pago, p_total);
    CALL sp_auditoria_juan ('Ejecutado desde juan');
END IF;
end //
DELIMITER ;


call sp_insertar_pago;



CREATE TABLE LOGEOS(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    MENSAJE VARCHAR(100),
    FECHA TIMESTAMP DEFAULT current_timestamp);




CREATE EVENT revision_juan
ON SCHEDULE EVERY 1 minute
DO
	INSERT  INTO LOGEOS(mensaje)
    values ('Ejecutado desde evento');
    
DELIMITER //    
CREATE PROCEDURE sp_auditoria_juan ( IN p_mensaje_auditoria varchar(40))
BEGIN
    
    INSERT INTO LOGEOS(mensaje)
    values ('Ejecutado desde Juan');
    
END //   
DELIMITER ;
call sp_auditoria_juan;
    
SHOW VARIABLES LIKE 'event_scheduler';



SELECT * from LOGEOS;

SHOW EVENTS;

SET GLOBAL event_scheduler = ON;


alter event revision_juan enable;
alter event revision_juan enable;
drop event revision_juan;


