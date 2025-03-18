#!/bin/bash
#SBATCH --output=/fsx/benjamin_burtenshaw/logs/%x-%j.out
#SBATCH --err=/fsx/benjamin_burtenshaw/logs/%x-%j.err
#SBATCH --nodes=16                   # number of nodes
#SBATCH --ntasks-per-node=1         # number of MP tasks
#SBATCH --gres=gpu:8                # number of GPUs per node
#SBATCH --time=10:00:00             # maximum execution time (HH:MM:SS)

export GPUS_PER_NODE=8
MAIN_PROCESS_IP=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)

srun accelerate launch \
    --config_file trl/examples/accelerate_configs/deepspeed_zero3.yaml \
    --num_processes $((SLURM_NNODES * GPUS_PER_NODE)) \
    --num_machines $SLURM_NNODES \
    --main_process_ip $MAIN_PROCESS_IP \
    --main_process_port 29502 \
    --machine_rank $SLURM_PROCID \
    --rdzv_backend c10d \
    trl/examples/scripts/sft_gemma3.py