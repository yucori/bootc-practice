sudo podman run \
  --rm \
  -it \
  --privileged \
  --security-opt label=type:unconfined_t \
  -v $HOME/.aws:/root/.aws:ro \
  -v ${CONFIG_PATH}:/config.toml:ro \
  -v /var/lib/containers/storage:/var/lib/containers/storage \
  --env AWS_PROFILE=default \
  quay.io/centos-bootc/bootc-image-builder:latest \
  --type ami \
  --aws-ami-name "${AMI_NAME}" \
  --aws-bucket "${S3_BUCKET_NAME}" \
  --aws-region "${AWS_REGION}" \
  "${ECR_IMAGE_PATH}"


sudo podman run --rm -it --privileged \
  --security-opt label=type:unconfined_t \
  -v $(pwd)/output:/output \
  -v $(pwd)/config.toml:/config.toml:ro \
  -v /var/lib/containers/storage:/var/lib/containers/storage \
  quay.io/centos-bootc/bootc-image-builder:latest \
  --type iso \
  --config /config.toml \
  --local \
  localhost/bootc


