# Comadreja Shop - Entorno de Desarrollo (Docker Compose)

## Descripción

Este proyecto configura el entorno de desarrollo para Comadreja Shop, una plataforma e-commerce multi-vendedor desarrollada con Laravel y Filament.

Incluye:

* Laravel 12 (ya integrado en el proyecto)
* MySQL 8
* Filament (panel administrativo)
* Docker Compose para entorno reproducible en equipo

---

## Requisitos

Antes de empezar necesitas:

* Docker Desktop
* Git
* VS Code (recomendado)

Verifica:

# En tu consola de Git Bash

```bash
docker --version
git --version
```

---

## Instalación

### 1. Clonar repositorio

```bash
git clone https://github.com/TU-USUARIO/comadreja-shop.git
cd comadreja-shop
```

---

### 2. Levantar contenedores

```bash
docker compose up -d --build
```

Esto levanta:

* Contenedor Laravel (app)
* Contenedor MySQL (db)

---

### 3. Instalar dependencias (obligatorio)

Entrar al contenedor:

**Windows (Git Bash):**

```bash
winpty docker exec -it comadreja_app bash
```

**PowerShell:**

```bash
docker exec -it comadreja_app bash
```

Luego ejecutar:

```bash
composer install
```

---

### 4. Configurar entorno

Si no existe `.env`:

```bash
cp .env.example .env
```

Editar `.env`:

```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=comadreja
DB_USERNAME=user
DB_PASSWORD=password
```

---

### 5. Generar key y migrar

```bash
php artisan key:generate
php artisan migrate
```

---

### 6. Crear usuario administrador (Filament)

```bash
php artisan make:filament-user
```

---

## Acceso

* Aplicación: http://localhost:8000
* Panel administrativo: http://localhost:8000/admin

---

## Error común

Si aparece error 500 o un mensaje relacionado con `tempnam`, ejecutar dentro del contenedor:

```bash
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
php artisan optimize:clear
```

---

## Cómo trabajar en el proyecto

### Abrir en VS Code

```bash
code .
```

Trabajar dentro de:

```
src/
```

---

### Probar cambios

Editar:

```
src/routes/web.php
```

Ejemplo:

```php
Route::get('/', function () {
    return "Funciona";
});
```

Guardar y recargar en el navegador.

---

## Flujo de trabajo en equipo

### 1. Actualizar código

```bash
git checkout develop
git pull origin develop
```

---

### 2. Crear rama

```bash
git checkout -b feature/nombre
```

---

### 3. Guardar cambios

```bash
git add .
git commit -m "RF-XXX descripcion"
git push origin feature/nombre
```

---

### 4. Crear Pull Request a `develop`

---

## Reglas importantes

No subir:

* `.env`
* `vendor/`
* base de datos

No trabajar directamente en `main`.

Usar ramas `feature/*`.

---

## Comandos útiles

Reiniciar contenedor:

```bash
docker restart comadreja_app
```

Entrar al contenedor:

```bash
docker exec -it comadreja_app bash
```

Limpiar cache:

```bash
php artisan optimize:clear
```

Ver contenedores:

```bash
docker ps
```

---

## Notas importantes

* Laravel ya está incluido en el proyecto (no ejecutar `create-project`)
* Solo se debe ejecutar `composer install`
* MySQL funciona por red interna de Docker (no expone puerto)
* Todo el código se encuentra en `src/`

---

## Equipo

* Adan Ballesillo Velázquez (DevOps)
* Nayeli Hernandez Ramirez (DBA)
* Karen Hernandez Martinez (UX/UI)
* Jhonatan Guerrero Rocha (Scrum Master / Líder Técnico)

---

## Proyecto académico

Tecnológico Superior de Jalisco
Materia: DevOps
