{%- from 'metricbeat/settings.sls' import metricbeat with context %}

elastic_repo:
  pkgrepo.managed:
    - humanname: Elastic
    - baseurl: https://artifacts.elastic.co/packages/5.x/yum
    - file: /etc/apt/sources.list.d/logstash.list
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - gpgcheck: 1

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
      hosts: {{ metricbeat.hosts}}

metricbeat-service:
  service.running:
    - name: metricbeat
    - enable: True
    - watch:
      - file: metricbeat-yml
