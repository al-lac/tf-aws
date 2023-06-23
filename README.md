# tf-aws - GitOps Repository

Example Terraform Repository for deploying AWS resources using various GitOps tools.

## Flux Terraform Controller

In the [tf-controller] folder of the repository, you can find a terraform plan that is automatically deployed via the [Flux Terraform Controller (tf-controller)](https://github.com/weaveworks/tf-controller).

The **Flux Terraform Controller** configuration can be found in the [flux-infra](https://github.com/al-lac/flux-infra) repository.

If everything is deployed correctly, you should find a website with a QR Code that links back to this repository [here](https://bucket.iamroot.at).

## Atlantis

The [atlantis](atlantis) folder contains a terraform plan, that if updated, will trigger the installed [Atlantis GitHub App](https://www.runatlantis.io/docs/access-credentials.html#github-app) to **plan** and **apply** changes on the configured [atlantis server](https://atlantis.iamroot.at).
Just open a [PR](https://github.com/al-lac/tf-aws/pull/2) with changes and atlantis should automatically start planning. If the plan looks good, apply it by commenting the following: ```atlantis apply```

The plans that should be used by **atlantis** are configured in the [atlantis.yaml](atlantis.yaml) file.

If everything is deployed correctly, you should find a website with a QR Code that links back to this repository [here](https://bucket-a.iamroot.at).

## Terraform Cloud

When changes get pushed into the [tf-cloud](tf-cloud) folder. [Terraform Cloud](https://app.terraform.io/app) will automatically start a new plan. The plan can be viewed and applied by going to the Terraform Cloud interface and clicking on **apply**.

If everything is deployed correctly, you should find a website with a QR Code that links back to this repository [here](https://bucket-tf.iamroot.at).
