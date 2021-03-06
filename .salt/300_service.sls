{% import "makina-states/services/monitoring/circus/macros.jinja" as circus  with context %}
{% set cfg = opts['ms_project'] %}
{% set data = cfg.data %}
include:
  - makina-states.services.monitoring.circus

# our wrapper drop privs after setting ulimits
{% set circus_data = {
     'cmd': 'bin/elasticsearch_suwrapper',
     'uid': 'root',
     'gid': 'root',
     'copy_env': True,
     'force_restart': true,
     'working_dir': data.prefix,
     'warmup_delay': "30",
     'max_age': 24*60*60} %}
{{ circus.circusAddWatcher(cfg.name, **circus_data) }}
