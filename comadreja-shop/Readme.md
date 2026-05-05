#  Comadreja Shop - Setup de Desarrollo

## Descripción

Este proyecto configura automáticamente el entorno de desarrollo para **Comadreja Shop** usando Docker.

Incluye:

* Laravel 12
* MySQL con persistencia
* Filament (panel admin)
* Entorno listo para trabajar en equipo

---

#  Requisitos

Antes de empezar necesitas:

* Docker instalado
* Git instalado
* VS Code (recomendado)

Verifica:

# En tu consola de Git Bash

```bash
docker --version
git --version
```

---

#  Instalación (IMPORTANTE seguir pasos)

## 1. Clonar repositorio

```bash
git clone https://github.com/TU-USUARIO/comadreja-shop.git
cd comadreja-shop
```

---

## 2. Dar permisos al script

```bash
chmod +x setup.sh
```

---

## 3. Ejecutar setup inicial

```bash
./setup.sh
```

 Esto puede tardar varios minutos porque:

* Se construye Docker
* Se instala Laravel
* Se instala Filament
* Se configura MySQL

---

#  4. PASO OBLIGATORIO (NO SALTAR)

Después del setup, ejecutar:

```bash
docker cp comadreja_app:/var/www/html ./src
```

 Esto trae el código a tu máquina para poder editarlo

---

#  5. Levantar contenedor con volumen (CLAVE)

Ejecuta en **una sola línea**:

```bash
docker rm -f comadreja_app && docker run -d --name comadreja_app --network comadreja_net -p 8000:80 -v "$(pwd -W)/src:/var/www/html" comadreja_app
```

---

#  Acceso

* App: http://localhost:8000
* Admin (Filament): http://localhost:8000/admin

---

#  Crear usuario admin

```bash
winpty docker exec -it comadreja_app php artisan make:filament-user
```

---

#  Cómo trabajar en el proyecto

## Abrir en VS Code

```bash
code .
```

Trabaja dentro de:

```bash
src/
```

---

##  Prueba rápida

Editar:

```bash
src/routes/web.php
```

Cambiar:

```php
return "Funciona ";
```

Guardar y recargar navegador.

---

# 🔄 Flujo de trabajo en equipo

## 1. Siempre actualizar antes de trabajar

```bash
git checkout develop
git pull origin develop
```

---

## 2. Crear tu rama

```bash
git checkout -b feature/lo-que-haras
```

---

## 3. Guardar cambios

```bash
git add .
git commit -m "RF-XXX descripcion"
git push origin feature/lo-que-haras
```

---

## 4. Crear Pull Request a `develop`

---

#  Reglas IMPORTANTES

 NO subir:

* `.env`
* `vendor`
* base de datos

NO trabajar en `main`

Usar ramas `feature/*`

---

#  Comandos útiles

Ver contenedores:

```bash
docker ps
```

Reiniciar app:

```bash
docker restart comadreja_app
```

Limpiar cache Laravel:

```bash
winpty docker exec -it comadreja_app php artisan optimize:clear
```

---

#  Problemas comunes

## No se reflejan cambios

```bash
docker restart comadreja_app
```

---

## Error de permisos

```bash
winpty docker exec -it comadreja_app chmod -R 775 storage bootstrap/cache
```

---

## No carga la página

```bash
docker ps
```

---

#  Notas

* Todo el código se edita en `src/`
* Docker usa esa carpeta en tiempo real
* No necesitas instalar Laravel manualmente

---

#  Equipo

* Adan Ballesillo Velázquez (DevOps)
* Nayeli Hernandez Ramirez (DBA)
* Karen Hernandez Martinez (UX/UI)
* Jhonatan Guerrero Rocha (Scrum Master / Líder Técnico)

---

#  Proyecto académico

Tecnológico Superior de Jalisco
Materia: DevOps
