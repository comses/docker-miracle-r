FROM comses/miracle-base

ARG MRO_VERSION=3.3.1
ARG MRO_FILE=microsoft-r-open-$MRO_VERSION.tar.gz
ARG MRO_URL=https://mran.revolutionanalytics.com/install/mro/$MRO_VERSION/$MRO_FILE

RUN yum -y update && yum -y install epel-release && yum -y groupinstall 'Development Tools' \
        && yum -y install wget postgresql-devel libffi-devel libicu-devel pango-devel librsvg2-devel zlib-devel libcurl-devel \
        && wget -q $MRO_URL && tar zxf $MRO_FILE && cd microsoft-r-open && sh install.sh -u -a \
        && R -e "install.packages(c('shiny', 'rmarkdown', 'data.table','raster','rasterVis', 'sqldf', 'lattice', 'latticeExtra', 'RPostgreSQL'), repos='https://cran.rstudio.com/')" \
        && R -e "install.packages('radiant', repos='http://vnijs.github.io/radiant_miniCRAN/')" \
        && rm -f /$MRO_FILE
