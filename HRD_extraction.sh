'''
The following script downloads .avp and .frd dropsonde files for all hurricanes within a specified date range
As well as all the skew-T plots in this range
There is an option to make separate directories for the .frd and .avp files, but this defaults to false
This means that all .frd and .avp will download to the current directory, and skewT will download to a separate
directory.
The script also "cleans up" by removing the .tar.gz files after extraction. 
'''

# Set this to true to make directories for the observations
make_dirs=false
date_str=2017091 # first date string, eg all dates beginning with a 1 in September 2017
date_2str=2017092 # second date string, eg all dates beginning with a 2 in September 2017
year=17
name=maria

# Extract the AVP files
if [ "$make_dirs" = "true" ]; then mkdir AVP; cd AVP; fi # Makes and enters directory

# Downloads all the AFRES AVP files, then all the HURR17 files
wget -r -np -nd -A $date_str'*_AVP.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/AFRES$year/raw/
wget -r -np -nd -A $date_2str'*_AVP.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/AFRES$year/raw/

wget -r -np -nd -A $date_str'*_AVP.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/HURR$year/raw/
wget -r -np -nd -A $date_2str'*_AVP.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/HURR$year/raw/

# Extracts files then exits directory
if [ "$make_dirs" = "true" ]; then for f in *.tar.gz; do tar xf "$f"; done; cd -; fi 

# Extract the FRD files
if [ "$make_dirs" = "true" ]; then mkdir FRD; cd FRD; fi
wget -r -np -nd -A $date_str'*_FRD.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/AFRES$year/operproc/
wget -r -np -nd -A $date_2str'*_FRD.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/AFRES$year/operproc/

wget -r -np -nd -A $date_str'*_FRD.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/HURR$year/operproc/
wget -r -np -nd -A $date_2str'*_FRD.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/HURR$year/operproc/

if [ "$make_dirs" = "true" ]; then for f in *.tar.gz; do tar xf "$f"; done; cd -; fi 

# Extract the skew-T files
mkdir skewT; cd skewT
wget -r -np -nd -A $date_str'*_XYPLOTS.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/AFRES$year/skewt/
wget -r -np -nd -A $date_2str'*_XYPLOTS.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/AFRES$year/skewt/

wget -r -np -nd -A $date_str'*_SKEWT.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/HURR$year/skewt/
wget -r -np -nd -A $date_2str'*_SKEWT.tar.gz' ftp://ftp.aoml.noaa.gov/hrd/pub/data/dropsonde/HURR$year/skewt/

# Decompress and go to prevous directory
for f in *.tar.gz; do tar xf "$f"; done; rm -f *.tar.gz; cd -

# Extract the radar images
mkdir radar; cd radar
wget -r -np -nd -A *.tar.gz ftp://ftp.aoml.noaa.gov/pub/hrd/data/radar/20$year/$name/
for f in *.tar.gz; do tar xf "$f"; done; rm -f *.tar.gz; cd -

# Decompresses
if [ "$make_dirs" = "false" ]; then for f in *.tar.gz; do tar xf "$f"; done; rm -f *.tar.gz; cd -; fi 

