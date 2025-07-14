# 修改了math.py的名字, 不然会有导入冲突
## rename src/flux/{math.py => flux_math.py}


# 安装cuda11.8 和 cudnn


# 安装conda python3.10环境
export http_proxy='10.249.36.23:8243'
export https_proxy='10.249.36.23:8243'

conda create -n flux python=3.10
conda activate flux

# 安装cu118对应的torch
pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu118

unset https_proxy
unset http_proxy

cd /root/paddlejob/workspace/env_run/flux
pip install -e ".[all]"

# 安装apex, 不然会报错：ModuleNotFoundError: No module named 'fused_layer_norm_cuda'
# 安装gcc-9 高版本的torch编译apex需要gcc-9
apt install gcc-9 g++-9
export CC=gcc-9
export CXX=g++-9
export http_proxy='10.249.36.23:8243'
export https_proxy='10.249.36.23:8243'
git clone https://github.com/NVIDIA/apex
cd apex
# 清理之前可能的缓存
python setup.py clean
python setup.py install --cpp_ext --cuda_ext


python src/flux/cli_fill.py