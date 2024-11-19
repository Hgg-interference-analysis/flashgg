#!/bin/bash -e
#####################################################
# **************** IMPORTANT NOTE ***************** #
# Increament Crab Startup Revision for every change #
#####################################################
#CMSDIST_FILE_REVISION=2

#Use crab-prod for default crab command
crab_pkg="crab"
if [ "${crab_pkg}" = "crab" ] ; then
  if [ "$CRABCLIENT_TYPE" = "" ] ; then CRABCLIENT_TYPE="prod" ; fi
  crab_pkg="crab-${CRABCLIENT_TYPE}"
fi

#Search for latest crab version for cmsos
cms_basedir="/cvmfs/cms.cern.ch/share/cms"
crab_dir="${cms_basedir}/${crab_pkg}/$(cat ${cms_basedir}/crab/1.0/etc/${crab_pkg}.latest)"

#Set crab runtime env and run crab
export PATH="${crab_dir}/bin${PATH:+:$PATH}"
export PYTHONPATH="${crab_dir}/lib${PYTHONPATH:+:$PYTHONPATH}"

echo $crab_dir


script_dir=${crab_dir}/bin/

[ -z "$CMSSW_VERSION" ] && echo "CMSSW is missing. You must do cmsenv first" && exit
CMSSW_Major=$(echo $CMSSW_VERSION | cut -d_ -f2)  # e.g. from CMSSW_13_1_x this is "13"                                            
CMSSW_Serie=$(echo $CMSSW_VERSION | cut -d_ -f3)  # e.g. from CMSSW_10_6_x this is "6"                                             

# CRABClient can use python3 starting from CMSSW_10_2                                                                              
[ $CMSSW_Major -gt 10 ] && python_cmd="python3"
[ $CMSSW_Major -eq 10 ] && [ $CMSSW_Serie -ge 2 ] && python_cmd="python3"

# but for crab submit, need to stick with same python as cmsRun, to allow                                                          
# proper processing of config files and proper PSet.pkl                                                                            
[ $CMSSW_Major -lt 12 ] &&  [ X$1 == Xsubmit ] && python_cmd="python"


python_cmd="python2.7"

if [ $python_cmd = "python3" ] ; then
  # can also include Rucio client (we do not want to deal with old python2 client)                                                 
  RUCIO_ENV=`${script_dir}/rucio_env.sh`
  export RUCIO_HOME=`echo $RUCIO_ENV|cut -d' ' -f1`
  RUCIO_PYTHONPATH=`echo $RUCIO_ENV|cut -d' ' -f2`
  # alter PYTHONPATH here to keep flexibility to add or append as we find better                                                   
  export PYTHONPATH=$RUCIO_PYTHONPATH:$PYTHONPATH
fi

# avoid pythonpath contamination  by user .local files                                                                             
export PYTHONNOUSERSITE=true

# finally run crab client                                                                                                         


echo CHIE?=${python_cmd} 
exec ${python_cmd} ${script_dir}/crab.py ${1+"$@"}
