Alter procedure [dbo].[sp_Conuslta_Mov_Inventario]
(
@accion char(1) = 0,  --C - I - A
@TipoMov varchar(3) = '', 
@NroDoc varchar(50) = '', 
@FecIni varchar(10) = '', 
@FecFin varchar(10) = ''

)
as begin 
set nocount on
declare 
@query nvarchar(max) = 'select Fecha_Transaccion, Tipo_Movimiento, Nro_Documento from Mov_inventario where 1 = 1',
@where nvarchar(max) = ''

if (@accion = 'C')
	
	--select * from Mov_inventario
	begin 
		if( LEN(@FecIni) > 0) and len(@FecFin) > 0
		set @query += ' and Fecha_Transaccion between ' + @FecIni + ' and '  + @FecFin + ''
		
		if Len(@TipoMov) > 0
		set @query += ' and Tipo_Movimiento = ''' + @TipoMov + ''''
		
		if Len(@NroDoc) > 0
		set @query += ' and Nro_Documento = ''' + @NroDoc + ''''
		
		print @query
		
		exec sp_executesql @query 
	end 
end 

Create  procedure [dbo].[sp_RegUpd_Mov_Inventario]
(
@Accion char(1)= '',
@COD_CIA varchar(50), 
@COMPANIA_VENTA_3 varchar(50),
@ALMACEN_VENTA varchar(50),
@TIPO_MOVIMIENTO varchar(50),
@TIPO_DOCUMENTO varchar(50),
@NRO_DOCUMENTO varchar(50),
@COD_ITEM_2 varchar(50), 
@Almacen_destino varchar(50)
)
as 
begin 

if(@Accion = 'I')
begin 
	Insert into Mov_Inventario (COD_CIA, COMPANIA_VENTA_3, ALMACEN_VENTA, TIPO_MOVIMIENTO, TIPO_DOCUMENTO, NRO_DOCUMENTO, COD_ITEM_2, ALMACEN_DESTINO)
	values
	(@COD_CIA, @COMPANIA_VENTA_3, @ALMACEN_VENTA , @TIPO_MOVIMIENTO , @TIPO_DOCUMENTO , @NRO_DOCUMENTO, @COD_ITEM_2, @Almacen_destino)
end 

if(@Accion = 'A')
begin 

	Update x 
	set 
	COD_CIA = @COD_CIA, 
	COMPANIA_VENTA_3 = @COMPANIA_VENTA_3, 
	ALMACEN_VENTA = @ALMACEN_VENTA , 
	TIPO_MOVIMIENTO = @TIPO_MOVIMIENTO , 
	@TIPO_DOCUMENTO = @TIPO_DOCUMENTO , 
	NRO_DOCUMENTO = @NRO_DOCUMENTO, 
	COD_ITEM_2	= @COD_ITEM_2,
	ALMACEN_DESTINO = @Almacen_destino
	from 
	Mov_Inventario x 
	where 
	COD_CIA = @COD_CIA
	and COMPANIA_VENTA_3 = @COMPANIA_VENTA_3
	and ALMACEN_VENTA = @ALMACEN_VENTA 
	and TIPO_MOVIMIENTO = @TIPO_MOVIMIENTO 
	and TIPO_DOCUMENTO = @TIPO_DOCUMENTO 
	and NRO_DOCUMENTO = @NRO_DOCUMENTO
	and COD_ITEM_2	= @COD_ITEM_2
	
end 

end 


/*
exec [sp_Conuslta_Mov_Inventario] 'C', '','', '15/06/2020', '17/06/2020'
exec [sp_Conuslta_Mov_Inventario] 'C', 'SD','', '', ''
exec [sp_Conuslta_Mov_Inventario] 'C', 'SD','74800', '', ''

select Fecha_Transaccion, Tipo_Movimiento, Nro_Documento from Mov_inventario

select * from Mov_Inventario where Almacen_Destino = 'xxxxx'
select * from Mov_Inventario where Almacen_Destino = 'yyyyyyyy'
exec [sp_RegUpd_Mov_Inventario] 'I','0','1','HU','II','JB','63487','221511','xxxxx'
exec [sp_RegUpd_Mov_Inventario] 'A','0','1','HU','II','JB','63487','221511','yyyyyyyy'
*/