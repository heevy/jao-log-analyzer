FROM ubuntu
RUN mkdir /dashboards
RUN apt-get update && apt-get install -yqq curl
ADD load-dashboards.sh /
CMD /load-dashboards.sh

