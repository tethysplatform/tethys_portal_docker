{% set TETHYS_PERSIST = salt['environ.get']('TETHYS_PERSIST') %}
{% set DAM_INVENTORY_MAX_DAMS = salt['environ.get']('DAM_INVENTORY_MAX_DAMS') %}
{% set EARTH_ENGINE_PRIVATE_KEY_FILE = salt['environ.get']('EARTH_ENGINE_PRIVATE_KEY_FILE') %}
{% set EARTH_ENGINE_SERVICE_ACCOUNT_EMAIL = salt['environ.get']('EARTH_ENGINE_SERVICE_ACCOUNT_EMAIL') %}
{% set THREDDS_SERVICE_NAME = 'tethys_thredds' %}
{% set POSTGIS_SERVICE_NAME = 'tethys_postgis' %}

Sync_Apps:
  cmd.run:
    - name: tethys db sync
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/init_apps_setup_complete" ];"

Set_Custom_Settings:
  cmd.run:
    - name: >
        tethys app_settings set dam_inventory max_dams {{ DAM_INVENTORY_MAX_DAMS }} &&
        tethys app_settings set earth_engine service_account_email {{ EARTH_ENGINE_SERVICE_ACCOUNT_EMAIL }} &&
        tethys app_settings set earth_engine private_key_file {{ EARTH_ENGINE_PRIVATE_KEY_FILE }}
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/init_apps_setup_complete" ];"

Link_Tethys_Services_to_Apps:
  cmd.run:
    - name: >
        tethys link persistent:{{ POSTGIS_SERVICE_NAME }} dam_inventory:ps_database:primary_db &&
        tethys link persistent:{{ POSTGIS_SERVICE_NAME }} postgis_app:ps_database:flooded_addresses &&
        tethys link spatial:{{ THREDDS_SERVICE_NAME }} thredds_tutorial:ds_spatial:thredds_service
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/init_apps_setup_complete" ];"

Sync_App_Persistent_Stores:
  cmd.run:
    - name: tethys syncstores all
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/init_apps_setup_complete" ];"

Flag_Init_Apps_Setup_Complete:
  cmd.run:
    - name: touch {{ TETHYS_PERSIST }}/init_apps_setup_complete
    - shell: /bin/bash
    - unless: /bin/bash -c "[ -f "{{ TETHYS_PERSIST }}/init_apps_setup_complete" ];"