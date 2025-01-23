nEvents=-1
outdir=untaggedTag_UL16preVFP_sigMC_new
dumper=$CMSSW_BASE/src/flashgg/Dumpers/workspaceStd.py
queue=tomorrow
json=$CMSSW_BASE/src/flashgg/Dumpers/UL16preVFP_sig.json

fggRunJobs.py  \
    --load $json \
    --stage-to /eos/cms/store/group/phys_higgs/cmshgg/rgargiul/trees/trees_sig/ggH_UL16preVFP/ \
    -d $outdir \
    -q $queue \
    -n 1000 \
    --no-copy-proxy -D -P \
    --no-use-tarball \
    -x cmsRun $dumper maxEvents=$nEvents copyInputMicroAOD=False
