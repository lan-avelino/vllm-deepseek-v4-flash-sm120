#!/usr/bin/env bash
set -euo pipefail

IMAGE=${IMAGE:-ghcr.io/ormandj/vllm-deepseek-v4-flash-sm120:v20}
MODEL_DIR=${MODEL_DIR:?Set MODEL_DIR to the DeepSeek-V4-Flash-0731 checkpoint directory}
CACHE_DIR=${CACHE_DIR:-$PWD/.cache/v20-mtp0}

mkdir -p "$CACHE_DIR"

exec docker run --rm \
  --gpus all \
  --ipc=host \
  --shm-size=32g \
  -p 8000:8000 \
  -v "$MODEL_DIR:/models/DeepSeek-V4-Flash-0731:ro" \
  -v "$CACHE_DIR:/cache" \
  -e SERVED_MODEL_NAME=deepseek-v4-flash \
  -e MODEL_PATH=/models/DeepSeek-V4-Flash-0731 \
  -e CUDA_VISIBLE_DEVICES=0,1 \
  -e PORT=8000 \
  -e MODE=dspark-mtp0 \
  -e BACKEND=b12x-a8 \
  -e TP_SIZE=2 \
  -e DCP_SIZE=1 \
  -e MAX_NUM_SEQS=16 \
  -e MAX_MODEL_LEN=1048576 \
  -e MAX_NUM_BATCHED_TOKENS=2048 \
  -e GPU_MEMORY_UTILIZATION=0.975 \
  -e LOAD_FORMAT=auto \
  -e KV_OFFLOADING_SIZE=0 \
  -e VLLM_USAGE_STATS_SERVER= \
  "$IMAGE" \
  /usr/local/bin/serve-ds4-flash.sh
