SELECT *FROM bar.PRODUCTO as fp ;

SELECT *FROM gventas.gv_producto as gp ;

SET lc_time_names = 'es_ES';
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- SELECT @@lc_time_names;
-- set @day_offset = 1; -- sunday SET DATEFIRST 1 ;  

insert into DPRODUCTO (   -- L
	   Cod_prod,
    Nom_prod,
    Prec_compra,
    Prec_venta,
	   Nom_cat,
    Nom_fam
)
SELECT  -- E
	-- T
	p.Cod_prod, CONCAT(p.Nom_prod, ' ', p.Concent, ' ', p.Presentac, ' frac', p.Fracciones ) as Nom_prodxx, 
    p.Prec_compra, p.Prec_venta,
	c.Nom_cat,
	f.Nom_fam
FROM bar.PRODUCTO as p  
	inner join bar.CATEGORIA as c on p.Cat_id= c.Cat_id 
    inner join bar.FAMILIA as f on c.Fam_id= f.Fam_id;

-- Dia, Mes, Trimestre, Año
insert into DTIEMPO (
	   Fecha,
    Dia_semana_desc,
    Mes_desc,
    Trim_desc,
    Año
)
SELECT 
	date_format(pe.Fecha_confirm, '%Y-%m-%d')  as Fecha
    ,DAYNAME(pe.Fecha_confirm ) AS DIA_SEMANA
	,MONTHNAME(pe.Fecha_confirm ) AS DES_MES
	,CONCAT('Trimestre ', QUARTER(pe.Fecha_confirm )) AS DES_TRIMESTRE
	,YEAR(pe.Fecha_confirm ) AS AÑO
FROM bar.VENTA as pe WHERE pe.Fecha_confirm IS NOT NULL
       GROUP BY date_format(pe.Fecha_confirm, '%Y-%m-%d')
       ORDER BY date_format(pe.Fecha_confirm, '%Y-%m-%d');
       

insert into DCLIENTE (
	Nom_cli
)
SELECT  c.Nom_cli FROM bar.CLIENTE as c;

insert into DVENDEDOR (
	Nom_vend
)
SELECT  v.Nom_vend FROM bar.VENDEDOR as v;


insert into H_VENTA (
	DTiem_id,
    DProd_id,
    DCli_id,
    DVend_id,
    Ventas,
    Can_unidades,
    Costos,
    Descuentos,
    Can_min_confirmacion,
    Can_min_despacho,
    Can_horas_entrega,
    Can_clientes
)
SELECT 
DT.DTiem_id,
DP.DProd_id,
DCLI.DCli_id,
DVEND.DVend_id,
sum(G.Ventas) as VENTAS,
sum(G.Cantidad) as CANT_UNID,
sum(G.Costos) as COSTOS,
sum(G.Descuentos) as DESCTOS,
sum(G.min_confirmacion) as CANT_MIN_CONFIRM,
sum(G.min_despacho) as CANT_MIN_DESPACH,
sum(G.horas_entrega2) as CANT_HORAS_ENTREGA,
COUNT(DISTINCT G.Nom_cli) AS Cant_clientes
FROM (
	SELECT  
		date_format(pe.Fecha_crea, '%Y-%m-%d') AS Fecha
		,TIMESTAMPDIFF(MINUTE,pe.Fecha_crea, pe.Fecha_confirm) AS min_confirmacion
		,TIMESTAMPDIFF(MINUTE,pe.Fecha_confirm, pe.Fecha_envio) AS min_despacho
		,ROUND( time_to_sec( TIMEDIFF(pe.Fecha_entrega, pe.Fecha_envio) ) /3600, 2) as horas_entrega2
		,p.Cod_prod
		 ,p.Nom_prod
		 ,c.Nom_cat
		 ,f.Nom_fam
		,ped.Cantidad
		,ped.Cantidad*ped.Prec_compra_un as Costos
		,ped.Cantidad*(ped.Prec_venta_un - ped.Total_desc_un ) as Ventas
		,ped.Cantidad*(ped.Total_desc_un ) as Descuentos
        ,cli.Nom_cli
        ,v.Nom_vend
	FROM bar.VENTA as pe
		inner join bar.VENTA_DET as ped on pe.Ped_id= ped.Ped_id 
		inner join bar.PRODUCTO as p on ped.Prod_id= p.Prod_id 
		inner join bar.CATEGORIA as c on p.Cat_id= c.Cat_id 
		inner join bar.FAMILIA as f on c.Fam_id= f.Fam_id 
        inner join bar.CLIENTE as cli on pe.Cli_id= cli.Cli_id 
        inner join bar.VENDEDOR as v on pe.Vend_id= v.Vend_id 
	)  AS G
    
    inner join DPRODUCTO AS DP ON G.Cod_prod = DP.Cod_prod
    inner join DTIEMPO AS DT ON G.Fecha = DT.Fecha
    inner join DCLIENTE AS DCLI ON G.Nom_cli = DCLI.Nom_cli
    inner join DVENDEDOR AS DVEND ON G.Nom_vend = DVEND.Nom_vend
	GROUP BY DP.DProd_id, DT.DTiem_id, DCLI.DCli_id, DVEND.DVend_id
;


SELECT 
 DP.DProd_id,
 DT.DTiem_id,
sum(G.Cantidad) as CANT_UNID,
sum(G.Ventas) as VENTAS,
COUNT(DISTINCT G.Cli_id) AS Cant_clientes
	FROM (SELECT 
			date_format(pe.Fecha_confirm, '%Y-%m-%d') AS Fecha,
			pe.Cli_id,
            p.Cod_prod, p.Nom_prod, c.Nom_cat, f.Nom_fam,
			ped.Cantidad,
			ped.Cantidad*(ped.Prec_venta_un - ped.Total_desc_un ) as Ventas

		 FROM bar.VENTA as pe
			inner join bar.VENTA_DET as ped on pe.Ped_id= ped.Ped_id
			inner join bar.PRODUCTO as p on ped.Prod_id= p.Prod_id 
			inner join bar.CATEGORIA as c on p.Cat_id= c.Cat_id 
			inner join bar.FAMILIA as f on c.Fam_id= f.Fam_id  ) as G
            
	 inner join DPRODUCTO AS DP ON G.Cod_prod = DP.Cod_prod
     inner join DTIEMPO AS DT ON G.Fecha = DT.Fecha
    GROUP BY  DP.DProd_id, DT.DTiem_id


SELECT 
 DP.Nom_fam,
 sum(Ventas) AS TOAL_VENTAS
 FROM H_VENTA AS HP
 inner join DPRODUCTO AS DP ON HP.DProd_id = DP.DProd_id
group by DP.Nom_fam
 ;
 

SELECT 
		sum(Ventas) as Ventas
	FROM reportes.H_VENTA as HP;

SELECT 
		DP.Nom_fam,
		sum(Ventas) as Ventas
	FROM reportes.H_VENTA as HP
		inner join DPRODUCTO AS DP ON HP.DProd_id = DP.DProd_id
	GROUP BY DP.Nom_fam;
    
SELECT 
		DP.Nom_cat,
		sum(Ventas) as Ventas
	FROM reportes.H_VENTA as HP
		inner join DPRODUCTO AS DP ON HP.DProd_id = DP.DProd_id
	GROUP BY DP.Nom_cat;

SELECT 
		DP.Nom_prod,
		sum(Ventas) as Ventas
	FROM reportes.H_VENTA as HP
		inner join DPRODUCTO AS DP ON HP.DProd_id = DP.DProd_id
	GROUP BY DP.Nom_prod;

SELECT 
		DT.Mes_desc,
		sum(Ventas) as Ventas
	FROM reportes.H_VENTA as HP
		inner join DTIEMPO AS DT ON HP.DTiem_id = DT.DTiem_id
	GROUP BY DT.Mes_desc;
    
SELECT 
		DT.Mes_desc,
		sum(Can_unidades) as can_PROD
	FROM reportes.H_VENTA as HP
		inner join DTIEMPO AS DT ON HP.DTiem_id = DT.DTiem_id
	GROUP BY DT.Mes_desc;