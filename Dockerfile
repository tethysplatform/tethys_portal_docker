FROM tethysplatform/tethys-core:latest

###############
# ENVIRONMENT #
###############
ENV DAM_INVENTORY_MAX_DAMS="50" \
    EARTH_ENGINE_PRIVATE_KEY_FILE="" \
    EARTH_ENGINE_SERVICE_ACCOUNT_EMAIL="" \
    THREDDS_TUTORIAL_TDS_USERNAME="admin" \
    THREDDS_TUTORIAL_TDS_PASSWORD="CHANGEME!" \
    THREDDS_TUTORIAL_TDS_CATALOG="/thredds/catalog/catalog.xml" \
    THREDDS_TUTORIAL_TDS_PRIVATE_PROTOCOL="http" \
    THREDDS_TUTORIAL_TDS_PRIVATE_HOST="localhost" \
    THREDDS_TUTORIAL_TDS_PRIVATE_PORT="8080" \
    THREDDS_TUTORIAL_TDS_PUBLIC_PROTOCOL="http" \
    THREDDS_TUTORIAL_TDS_PUBLIC_HOST="localhost" \
    THREDDS_TUTORIAL_TDS_PUBLIC_PORT="8080"

#############
# ADD FILES #
#############
COPY tethysapp-bokeh_tutorial ${TETHYS_HOME}/apps/tethysapp-bokeh_tutorial
COPY tethysapp-dam_inventory ${TETHYS_HOME}/apps/tethysapp-dam_inventory
COPY tethysapp-earth_engine ${TETHYS_HOME}/apps/tethysapp-earth_engine
COPY tethysapp-postgis_app ${TETHYS_HOME}/apps/tethysapp-postgis_app
COPY tethysapp-thredds_tutorial ${TETHYS_HOME}/apps/tethysapp-thredds_tutorial

###################
# ADD THEME FILES #
###################
COPY images/ /tmp/custom_theme/images/

###########
# INSTALL #
###########
# Activate tethys conda environment during build
ARG MAMBA_DOCKERFILE_ACTIVATE=1
# Bokeh App
RUN cd ${TETHYS_HOME}/apps/tethysapp-bokeh_tutorial && \
    tethys install --no-db-sync
# Dam Inventory
RUN cd ${TETHYS_HOME}/apps/tethysapp-dam_inventory && \
    tethys install --no-db-sync
# Earth Engine
RUN cd ${TETHYS_HOME}/apps/tethysapp-earth_engine && \
    tethys install --no-db-sync
# PostGIS App
RUN cd ${TETHYS_HOME}/apps/tethysapp-postgis_app && \
    tethys install --no-db-sync
# THREDDS Tutorial
RUN cd ${TETHYS_HOME}/apps/tethysapp-thredds_tutorial && \
    tethys install --no-db-sync

##################
# ADD SALT FILES #
##################
COPY salt/ /srv/salt/

#########
# PORTS #
#########
EXPOSE 80

#######
# RUN #
#######
WORKDIR ${TETHYS_HOME}
CMD bash run.sh