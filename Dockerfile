FROM tethysplatform/tethys-core:3.4.1

###############
# ENVIRONMENT #
###############
ENV DAM_INVENTORY_MAX_DAMS="50" \
    EARTH_ENGINE_PRIVATE_KEY_FILE="" \
    EARTH_ENGINE_SERVICE_ACCOUNT_EMAIL="" \
    THREDDS_TUTORIAL_TDS_USERNAME="admin" \
    THREDDS_TUTORIAL_TDS_PASSWORD="CHANGEME!" \
    THREDDS_TUTORIAL_TDS_PROTOCOL="http" \
    THREDDS_TUTORIAL_TDS_HOST="localhost" \
    THREDDS_TUTORIAL_TDS_PORT="8080"

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
# Bokeh App
RUN /bin/bash -c "cd ${TETHYS_HOME}/apps/tethysapp-bokeh_tutorial && \
    . ${CONDA_HOME}/bin/activate tethys && \
    tethys install --no-db-sync"
# Dam Inventory
RUN /bin/bash -c "cd ${TETHYS_HOME}/apps/tethysapp-dam_inventory && \
    . ${CONDA_HOME}/bin/activate tethys && \
    tethys install --no-db-sync"
# Earth Engine
RUN /bin/bash -c "cd ${TETHYS_HOME}/apps/tethysapp-earth_engine && \
    . ${CONDA_HOME}/bin/activate tethys && \
    tethys install --no-db-sync"
# PostGIS App
RUN /bin/bash -c "cd ${TETHYS_HOME}/apps/tethysapp-postgis_app && \
    . ${CONDA_HOME}/bin/activate tethys && \
    tethys install --no-db-sync"
# THREDDS Tutorial
RUN /bin/bash -c "cd ${TETHYS_HOME}/apps/tethysapp-thredds_tutorial && \
    . ${CONDA_HOME}/bin/activate tethys && \
    tethys install --no-db-sync"

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
