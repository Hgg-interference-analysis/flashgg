nEvents=-1
outdir=UL18_intMC_newFNUF_VBFTag0
dumper=$CMSSW_BASE/src/flashgg/Dumpers/workspaceStd.py
queue=tomorrow
json=$CMSSW_BASE/src/flashgg/Dumpers/UL18_int_m125.json

fggRunJobs.py  \
    --load $json \
    --stage-to /eos/user/a/amkrishn/hggWidth/mcNtuples/condor_output/2018/UL18_intMC_newFNUF_VBFTag0 \
    -d $outdir \
    -q $queue \
    -n 200 \
    --no-copy-proxy -D -P \
    --no-use-tarball \
    -x cmsRun $dumper maxEvents=$nEvents copyInputMicroAOD=True \
    --cont --resubmit-missing
