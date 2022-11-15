module.exports = {
  /**
  * Permite ir al carro de compra y obtener los productos de los usuarios
  */
  carroCompra: async (request, response) => {
    if (!request.session || !request.session.cliente) {
      return response.redirect('/');
    }
    let elementos = await CarroCompra.find({cliente: request.session.cliente.id}).populate('foto');
    let totalCompra = 0;
    elementos.forEach(elemento => {
      totalCompra += parseInt(elemento.foto.precio);
    });
    return response.view('pages/carro_de_compra', {elementos: elementos, totalCompra: totalCompra});
  },
  /**
  * Permite agregar un producto al carro de compra
  */
  agregarCarroCompra: async (request, response) => {
    let foto = await CarroCompra.findOne({foto: request.params.fotoId, cliente: request.session.cliente.id});
    if (foto) {
      request.addFlash('mensaje', 'La foto ya había sido agregada al carro de compra');
    }
    else{
      await CarroCompra.create({
        cliente: request.session.cliente.id,
        foto: request.params.fotoId
      });
      request.session.carroCompra = await CarroCompra.find({ cliente: request.session.cliente.id });
      request.addFlash('mensaje', 'Foto agregada al carro de compra');
    }
    return response.redirect('/');
  },
  /**
  * permite eliminar una foto del carro de compra
  */
  eliminarCarroCompra: async (request, response) =>{
    let foto = await CarroCompra.findOne({foto: request.params.fotoId, cliente: request.session.cliente.id});
    if (foto) {
      await CarroCompra.destroy({
        cliente: request.session.cliente.id,
        foto: request.params.fotoId
      });
      request.session.carroCompra = await CarroCompra.find({cliente: request.session.cliente.id});
      request.addFlash('mensaje', 'Foto eliminada del carro de compra');
    }
    return response.redirect('/carro-de-compra');
  },
  /**
   * Permite obtener todas las fotos del carro de compra
   * y almacenarlas en una nueva orden y eliminar los elementos del carro de compra
   */
  procesarCompra: async (request, response) =>{
    //Nos permite obtener el total de la compra
    let elementos = await CarroCompra.find({cliente: request.session.cliente.id}).populate('foto');
    let totalCompra = 0;
    elementos.forEach(elemento => {
      totalCompra += parseInt(elemento.foto.precio);
    });

    //Crear la orden
    let orden = await Orden.create({
      fecha: new Date(),
      cliente: request.session.cliente.id,
      cantidad: request.session.carroCompra.length,
      total: totalCompra
    }).fetch();

    //Crear el detalle de las compras
    for(let i=0; i< request.session.carroCompra.length; i++){
      await OrdenDetalle.create({
        orden: orden.id,
        foto: request.session.carroCompra[i].foto
      });
    }

    //Limpiar carro de compra
    await CarroCompra.destroy({cliente: request.session.cliente.id});
    request.session.carroCompra = [];
    request.addFlash('mensaje', 'Compra realizada con exito!');
    return response.redirect('/');
  },
  /**
  * Obtener todas las compras que se han realizado
  */
  misOrdenes: async (request, response) =>{
    if(!request.session || !request.session.cliente){
      return response.redirect('/');
    }

    let ordenes = await Orden.find({cliente: request.session.cliente.id}).sort('id desc');
    response.view('pages/mis_ordenes',{ordenes});
  },
  /**
  * Permite ir a la paginá del detalle de la orden
  */
  detalleOrden: async (request, response) =>{
    if (!request.session || !request.session.cliente) {
      return response.redirect('/');
    }

    let orden = await Orden.find({ cliente: request.session.cliente.id, id: request.params.ordenId}).populate('cliente');

    if (!orden) {
      return response.redirect('/mis-ordenes');
    }

    if (orden && orden.detalles === 0) {
      return response.view('pages/detalle_orden', { orden });
    }

    orden[0].detalle = await OrdenDetalle.find({ orden: request.params.ordenId }).populate('foto');
    return response.view('pages/detalle_orden', { orden });
  }
}