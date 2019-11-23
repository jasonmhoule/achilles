FROM rocker/verse
MAINTAINER Jason Houle (jasonmhoule@gmail.com)

RUN apt-get -qqy update && apt-get install -qqy \
        openssh-client \
        qpdf
        
## Install packages from CRAN
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
    googleAuthR \ 
    googleComputeEngineR \ 
    googleAnalyticsR \ 
    searchConsoleR \ 
    ## googleCloudStorageR \
    bigQueryR \ 
    zip \
## install Github packages
    && installGithub.r MarkEdmondson1234/youtubeAnalyticsR \
                       MarkEdmondson1234/googleID \
                       cloudyr/googleCloudStorageR \
                       cloudyr/googleComputeEngineR \
## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Download config files from GCS
RUN R -e 'googleCloudStorageR::gcs_load(".httr-oauth", "jmh_config", saveToDisk = ".httr-oauth"); \
          googleCloudStorageR::gcs_load(".gitignore", "jmh_config", saveToDisk = ".gitignore"); \
          googleCloudStorageR::gcs_load(".gitconfig", "jmh_config", saveToDisk = ".gitconfig")' \
    && mkdir .ssh \
    && R -e 'googleCloudStorageR::gcs_load("id_rsa", "jmh_config", saveToDisk = ".ssh/id_rsa"); \
             googleCloudStorageR::gcs_load("id_rsa.pub", "jmh_config", saveToDisk = ".ssh/id_rsa.pub"); \
             googleCloudStorageR::gcs_load("known_hosts", "jmh_config", saveToDisk = ".ssh/known_hosts")'

COPY Rprofile.site /usr/local/lib/R/etc/Rprofile.site
