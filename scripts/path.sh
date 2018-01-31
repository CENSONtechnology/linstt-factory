lvcsrRootDir=/opt/lvcsrPlatform
export KALDI_ROOT=$lvcsrRootDir/tools/kaldi

export PATH=$KALDI_ROOT/tools/irstlm/bin:$PATH
export PATH=$KALDI_ROOT/tools/sctk/bin:$PATH
export PATH=$KALDI_ROOT/tools/sph2pipe_v2.5:$PATH
export PATH=$KALDI_ROOT/tools/openfst/bin:$PATH
export PATH=$KALDI_ROOT/tools/fstbin/:$PATH
export IRSTLM=$KALDI_ROOT/tools/irstlm

PYTHON='python2.7'
PYTHON3='python3'

# Sequitur G2P executable
sequitur=$KALDI_ROOT/tools/sequitur/g2p.py
sequitur_path="$(dirname $sequitur)/lib/$PYTHON/site-packages"

export CUDA_HOME=/usr/local/cuda-7.5 
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export PATH=$CUDA_HOME/bin:$PATH

export PATH=\
$KALDI_ROOT/src/bin:$KALDI_ROOT/src/chainbin:\
$KALDI_ROOT/src/featbin:$KALDI_ROOT/src/fgmmbin:\
$KALDI_ROOT/src/fstbin:$KALDI_ROOT/src/gmmbin:\
$KALDI_ROOT/src/ivectorbin:$KALDI_ROOT/src/kwsbin:\
$KALDI_ROOT/src/latbin:$KALDI_ROOT/src/lmbin:\
$KALDI_ROOT/src/nnet2bin:$KALDI_ROOT/src/nnet3bin:\
$KALDI_ROOT/src/nnetbin:$KALDI_ROOT/src/online2bin:\
$KALDI_ROOT/src/onlinebin:$KALDI_ROOT/src/sgmm2bin:\
$KALDI_ROOT/src/sgmmbin:$PATH

export PATH=$lvcsrRootDir/scripts:$lvcsrRootDir/scripts/utils:$lvcsrRootDir/scripts/steps:$PATH
#export LC_ALL=C
export LANG=fr_Fr.UTF-8
export LANGUAGE=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
