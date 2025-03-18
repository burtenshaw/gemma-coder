# Make Gemma Coder

## Installation

### 1. Install `uv`

```bash
uv venv 
source .venv/bin/activate
uv pip install --upgrade pip
```

### 2. Install dependencies

```bash
uv pip install -r requirements.txt
```

### 3. Install `vllm`

```shell
git clone https://github.com/vllm-project/vllm.git@64fc2193dc777f764b5e6b3dde7bdef340ade1c5
cd vllm
VLLM_USE_PRECOMPILED=1 pip install --editable .
```

### 4. Install `flash-attn`

```shell
uv pip install setuptools && uv pip install flash-attn --no-build-isolation
```

## Train

### 1. Login to Hugging Face and Weights & Biases

```shell
huggingface-cli login
wandb login
```

### 2. Clone TRL

```shell
git clone https://github.com/huggingface/trl@07cfe1677e552b7d5c92b7740e5b2f0b057661d8
```

### 3.1 Train locally

```shell
python trl/examples/scripts/sft_gemma3.py
```

### 3.2 Train on the cluster

```shell
sbatch --job-name=gemma_code train.slurm
```


## Evaluate

```shell
bash eval.sh google/gemma-3-12b-it
```