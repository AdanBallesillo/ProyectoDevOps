#  Comadreja Shop - Entorno con Docker

##  Descripción

Este proyecto configura automáticamente un entorno de desarrollo para **Comadreja Shop** utilizando Docker.

Incluye:

* Laravel (instalado automáticamente)
* MySQL con persistencia (volumen)
* Red Docker para comunicación
* Panel administrativo con Filament

---

##  Requisitos

Antes de comenzar, asegúrate de tener instalado:

* Docker
* Git

Verificar instalación:

```bash
docker --version
git --version
```

---

##  Instalación paso a paso

### 1. Clonar el repositorio

```bash
git clone https://github.com/TU-USUARIO/comadreja-shop.git
cd comadreja-shop
```

---

### 2. Dar permisos al script

```bash
chmod +x setup.sh
```

---

### 3. Ejecutar instalación automática

```bash
./setup.sh
```

 Este proceso puede tardar unos minutos porque:

* Se construye la imagen Docker
* Se descarga Laravel
* Se instala Filament
* Se configuran base de datos y migraciones

---

##  Acceso al sistema

Una vez terminado:

* Aplicación:
  http://localhost:8000

* Panel de administración (Filament):
  http://localhost:8000/admin

---

##  Crear usuario administrador

Después de la instalación, ejecutar:

```bash
docker exec -it comadreja_app php artisan make:filament-user
```

Ingresar:

* Nombre
* Correo
* Contraseña

---

##  Comandos útiles

Ver contenedores:

```bash
docker ps
```

Entrar al contenedor:

```bash
docker exec -it comadreja_app bash
```

Detener contenedores:

```bash
docker stop comadreja_app comadreja_db
```

Eliminar contenedores:

```bash
docker rm comadreja_app comadreja_db
```

---

##  Solución de problemas

###  No carga la página

Verifica contenedores:

```bash
docker ps
```

---

###  Error de base de datos

Espera unos segundos y reinicia:

```bash
docker restart comadreja_db
```

---

###  Error de permisos

Dentro del contenedor:

```bash
chmod -R 777 storage bootstrap/cache
```

---

##  Notas

* No es necesario instalar Laravel manualmente
* Todo se configura automáticamente con `setup.sh`
* La base de datos usa volumen, por lo que los datos no se pierden

---

##  Equipo

* Adan Ballesillo Velázquez (DevOps)
* Nayeli Hernandez Ramirez (DBA)
* Karen Hernandez Martinez (UX/UI)
* Jhonatan Guerrero Rocha (Scrum Master / Líder Técnico)

---

##  Proyecto académico

Tecnológico Superior de Jalisco
Materia: DevOps
