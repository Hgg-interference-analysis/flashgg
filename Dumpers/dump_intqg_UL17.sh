nEvents=-1
outdir=untaggedTag_UL17_intqgMC_new
dumper=$CMSSW_BASE/src/flashgg/Dumpers/workspaceStd.py
queue=tomorrow
json=$CMSSW_BASE/src/flashgg/Dumpers/UL17_intqg.json

fggRunJobs.py  \
    --load $json \
    --stage-to /eos/cms/store/group/phys_higgs/cmshgg/HGG_Int/Mattia/ggH_UL17/ \
    -d $outdir \
    -q $queue \
    -n 1000 \
    --no-copy-proxy -D -P \
    --no-use-tarball \
    -x cmsRun $dumper maxEvents=$nEvents copyInputMicroAOD=False
