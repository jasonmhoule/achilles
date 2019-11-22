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
    ## googleAnalyticsR \ 
    searchConsoleR \ 
    ## googleCloudStorageR \
    ## bigQueryR \ 
    zip \
## install Github packages
    && installGithub.r MarkEdmondson1234/youtubeAnalyticsR \
                       MarkEdmondson1234/googleID \
                       MarkEdmondson1234/googleCloudStorageR \
                       cloudyr/googleCloudStorageR \
                       cloudyr/googleComputeEngineR \
## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## COPY Rprofile.site /usr/local/lib/R/etc/Rprofile.site
