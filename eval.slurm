#!/bin/bash
#SBATCH --output=/fsx/benjamin_burtenshaw/logs/%x-%j.out
#SBATCH --err=/fsx/benjamin_burtenshaw/logs/%x-%j.err
#SBATCH --nodes=4                   # number of nodes
#SBATCH --ntasks-per-node=1         # number of MP tasks
#SBATCH --gres=gpu:8                # number of GPUs per node
#SBATCH --time=10:00:00             # maximum execution time (HH:MM:SS)

MODEL_ID=google/gemma-3-12b-it
export GPUS_PER_NODE=8
MAIN_PROCESS_IP=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)

srun python scripts/run_benchmarks.py --model-id $MODEL_ID  --benchmarks lcb