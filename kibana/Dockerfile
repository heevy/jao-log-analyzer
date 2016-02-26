FROM nginx
RUN apt-get update && apt-get install -yqq git
RUN git clone --depth 1 -b terms_tophits_panel https://github.com/heevy/kibana-extended.git
RUN cp -r kibana-extended/src/* /usr/share/nginx/html
RUN rm -rf kibana-extended
ADD default.conf /etc/nginx/conf.d/
RUN sed -i 's|elasticsearch:.*,|elasticsearch: "http://"+window.location.hostname,|g' /usr/share/nginx/html/config.js


