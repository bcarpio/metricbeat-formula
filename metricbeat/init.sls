{%- from 'metricbeat/settings.sls' import metricbeat with context %}

include:
  - elasticyumrepo

metricbeat:
  pkg.installed:
    - pkgs:
      - metricbeat

metricbeat-yml:
  file.managed:
    - name: /etc/metricbeat/metricbeat.yml
    - source: salt://metricbeat/files/metricbeat.yml
    - template: jinja
    - context:
      username: {{ metricbeat.username }}
      password: {{ metricbeat.password }}

metricbeat-service:
  service.running:
    - name: metricbeat
    - enable: True
    - watch:
      - file: metricbeat-yml
