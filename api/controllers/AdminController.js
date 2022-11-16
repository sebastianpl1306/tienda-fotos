const path = require('path');
const fs = require('fs');

module.exports = {
  inicioSesion: async (request, response) =>{
    response.view('pages/admin/inicio_sesion');
  },
  /**
  * Permite buscar un usuario que cumpla con las credenciales ingresadas
  */
  procesarInicioSesion: async (request, response) =>{
    //Busca un registro con esas credenciales
    let admin = await Admin.findOne({email: request.body.correo, clave: request.body.clave, activo: true});

    //comprueba si se encontro un registro y redirije a la pagina de inicio
    if (admin) {
      request.session.admin = admin;
      request.session.cliente = undefined;
      request.addFlash('mensaje','Sesión iniciada');
      return response.redirect('/admin/principal');
    } else {
      //Si no encuentra un admin redirije nuevamente al inicio de sesion y envia un mensaje
      request.addFlash('mensaje','Email o contraseña invalidos');
      return response.redirect('/admin/inicio-sesion');
    }
  },
  principal:  async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }
    let fotos = await Foto.find();
    response.view('pages/admin/principal',{fotos});
  },
  /**
  * Finaliza la session actual
  */
  cerrarSesion: async (request, response) =>{
    request.session.destroy();
    return response.redirect('/');
  },
  /**
  * Permite ir al formulario para agregar una foto
  */
  agregarFoto: async (request, response) =>{
    response.view('pages/admin/agregar_foto');
  },
  /**
  * Permite procesar el formulario de agregar una foto
  */
  procesarAgregarFoto: async (request, response) =>{
    let foto = await Foto.create({
      titulo: request.body.titulo,
      precio: request.body.precio,
      descripcion: request.body.descripcion,
      activa: false
    }).fetch();

    request.file('foto').upload({}, async (error, archivos) =>{
      if(archivos && archivos[0]){
        let upload_path = archivos[0].fd;
        let ext = path.extname(upload_path);

        await fs.createReadStream(upload_path).pipe(fs.createWriteStream(path.resolve(sails.config.appPath, `assets/images/${foto.id}${ext}`)));

        await Foto.update({id: foto.id}, {ruta: `${foto.id}${ext}`, activa: true});
        request.addFlash('menasaje', 'Foto agregada');
        return response.redirect('/admin/principal');
      }
    });
    request.addFlash('menasaje', 'No hay foto seleccionada');
    return response.redirect('/admin/agregar-foto');
  },
  /**
  * Nos redirige a la pagina de clientes
  */
  clientes: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let clientes = await Cliente.find();
    response.view('pages/admin/clientes',{clientes});
  },
  /**
  * Nos redirige a la pagina de ordenes de un cliente
  */
  ordenesCliente: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }
    let ordenes = await Orden.find({cliente: request.params.clienteId});
    response.view('pages/admin/ordenes_cliente',{ordenes});
  },
  /**
  * Nos redirige a la pagina detalle de orden
  */
  ordenClienteDetalle: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let orden = await Orden.find({id: request.params.ordenId}).populate('cliente');

    if (!orden) {
      return response.redirect('/admin/clientes');
    }

    if (orden && orden.detalles === 0) {
      return response.view('pages/admin/orden_cliente_detalle', { orden });
    }

    orden[0].detalle = await OrdenDetalle.find({ orden: request.params.ordenId }).populate('foto');
    return response.view('pages/admin/orden_cliente_detalle', { orden });
  },
  /**
  * Nos permite desactivar una foto
  */
  desactivarFoto: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let foto = await Foto.findOne({id: request.params.fotoId});

    if(!foto){
      request.addFlash('mensaje', 'No se encontro la foto');
      return response.redirect('/admin/principal');
    }

    await Foto.update({id: request.params.fotoId},{activa: !foto.activa});
    request.addFlash('mensaje', 'Se cambio el estado con exito');

    return response.redirect('/admin/principal');
  },
  /**
  * Nos redirige a la pagina detalle de orden
  */
  cambiarEstadoCliente: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let cliente = await Cliente.findOne({id: request.params.clienteId});

    if(!cliente){
      request.addFlash('mensaje', 'No se encontro el cliente');
      return response.redirect('/admin/clientes');
    }

    await Cliente.update({id: request.params.clienteId},{activo: !cliente.activo});
    request.addFlash('mensaje', 'Se cambio el estado con exito');

    return response.redirect('/admin/clientes');
  },
  /**
  * Nos redirige a la pagina de administradores
  */
  administradores: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let administradores = await Admin.find();
    response.view('pages/admin/administradores',{administradores});
  },
  /**
  * Nos redirige a la pagina detalle de orden
  */
  cambiarEstadoAdministrador: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let administrador = await Admin.findOne({id: request.params.adminId});

    if(!administrador){
      request.addFlash('mensaje', 'No se encontro el administrador');
      return response.redirect('/admin/administradores');
    }

    if(administrador.id === request.session.admin.id){
      request.addFlash('mensaje', 'No se puede desactivar a sí mismo');
      return response.redirect('/admin/administradores');
    }

    await Admin.update({id: request.params.adminId},{activo: !administrador.activo});
    request.addFlash('mensaje', 'Se cambio el estado con exito');

    return response.redirect('/admin/administradores');
  },
  /**
  * Nos redirige a la pagina de administradores
  */
  dashboard: async (request, response) =>{
    if (!request.session || !request.session.admin) {
      request.addFlash('mensaje', 'Sesión inválida');
      return response.redirect('/admin/inicio-sesion');
    }

    let numeroClientes = await Cliente.count();
    let numeroOrdenes = await Orden.count();
    let numeroFotos = await Foto.count();

    response.view('pages/admin/dashboard',{numeroClientes, numeroOrdenes, numeroFotos});
  },
}