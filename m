From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Wed, 11 Aug 2010 18:17:55 -0700
Subject: [PATCH 0/2] Platform-specific IOMMU code for MSM8x60
Message-ID: <1281575877-1074-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
This is the second part of what is needed for IOMMU support on the MSM8x60.
This is mainly a bunch of platform data specifying I/O addresses, IRQ numbers,
etc, and the probe functions to initialize the IOMMUs and their context banks.

The main support for the 8x60 will be sent out in a little while, but I would
appreciate it if you guys could look over these patches and give me whatever
comments you have.

Thanks
Steve

Stepan Moskovchenko (2):
  msm: Platform initialization for the IOMMU driver
  msm: Platform data for MSM8x60 IOMMU devices

 arch/arm/mach-msm/devices-msm8x60-iommu.c |  881 +++++++++++++++++++++++++++++
 arch/arm/mach-msm/iommu_dev.c             |  360 ++++++++++++
 2 files changed, 1241 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/devices-msm8x60-iommu.c
 create mode 100644 arch/arm/mach-msm/iommu_dev.c

 Sent by an employee of the Qualcomm Innovation Center, Inc.
 The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
