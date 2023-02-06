# Demonstration Tethys Portal Docker Project

This repository demonstrates how to make a Docker image containing a custom Tethys Portal with apps installed. The apps installed are the solutions to several of the Tethys Platform tutorials and include:

* [Dam Inventory](https://github.com/tethysplatform/tethysapp-dam_inventory.git)
* [THREDDS Tutorial](https://github.com/tethysplatform/tethysapp-thredds_tutorial)
* [Earth Engine](https://github.com/tethysplatform/tethysapp-earth_engine.git)
* [PostGIS App](https://github.com/tethysplatform/tethysapp-postgis_app.git)
* [Bokeh Tutorial](https://github.com/tethysplatform/tethysapp-bokeh_tutorial)

# Checkout

```
git clone --recursive-submodules https://github.com/tethysplatform/tethys_portal_docker.git
```

# Build

```
docker compose build web
```

# Run

1. Create Data Directories

```
mkdir -p data/db
mkdir -p data/tethys
mkdir -p data/thredds
mkdir -p keys/gee
mkdir -p logs/tethys
mkdir -p logs/thredds/thredds
mkdir -p logs/thredds/tomcat
```

2. Acquire a Earth Engine Service Account and Key file (see Step 1 of [Google Earth Engine Service Account](http://docs.tethysplatform.org/en/stable/tutorials/google_earth_engine/part_3/service_account.html)).

3. Add the Google Earth Engine service account JSON key file to the `keys/gee` directory.

4. Create copies of the `.env` files in the `env` directory and modify the settings appropriately.

5. Update `env_file` sections in the `docker-compose.yml` to point to your copies of the `.env` files.

6. Start containers:

```
docker compose up -d
```