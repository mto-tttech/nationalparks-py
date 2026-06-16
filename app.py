from mod_wsgi import express

express.start_server(
    application_type='module',
    entry_point='wsgi',
    port=8080,
    log_to_terminal=True,
    log_level='info',
    access_log=True,
    inactivity_timeout=60,
    url_aliases=[('/ws/healthz/', '/opt/app-root/src/LICENSE')]
)
