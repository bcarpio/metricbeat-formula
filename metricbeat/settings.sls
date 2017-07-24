{% set p    = salt['pillar.get']('metricbeat', {}) %}
{% set g    = salt['grains.get']('metricbeat', {}) %}

{%- set metricbeat = {} %}
{%- do metricbeat.update( {
  'username' : p.get('username', 'elastic'),
  'password' : p.get('password', 'changeme'),
}) %}
