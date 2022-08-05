FROM rocker/r-ver:4.2.1

# install the linux libraries needed for plumber
RUN apt-get update -qq && apt-get install -y \
      libssl-dev \
      libcurl4-gnutls-dev
      
# install plumber and any other needed packages
RUN R -e "install.packages('plumber', dependencies = TRUE)"
RUN R -e "install.packages('swagger', dependencies = TRUE)"

# copy everything from the current directory into the container
COPY / /

# open port 80 to traffic
EXPOSE 80

# when the container starts, start the run-plumber.R script
ENTRYPOINT ["Rscript", "run-plumber.R"]

