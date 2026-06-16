FROM registry.access.redhat.com/ubi9/python-312

USER root

# Install Apache + build tools (needed for mod_wsgi)
RUN dnf install -y httpd httpd-devel gcc make && \
    dnf clean all

USER 1001

WORKDIR /opt/app-root/src

# Copy your app
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080


CMD ["mod_wsgi-express", "start-server", "wsgi.py", \
     "--log-to-terminal", \
     "--log-level", "info", \
     "--access-log", \
     "--port", "8080", \
     "--trust-proxy-header", "X-Forwarded-For", \
     "--trust-proxy-header", "X-Forwarded-Port", \
     "--trust-proxy-header", "X-Forwarded-Proto", \
     "--application-type", "module", \
     "--entry-point", "application", \
     "--inactivity-timeout", "60"]
