From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun,  8 Nov 2015 20:57:43 -0500
Subject: [PATCH V2 0/3] scsi: mptxsas: updates for ARM64
Message-ID: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V1: (https://lkml.org/lkml/2015/11/4/856)
Changes from V1: (https://lkml.org/lkml/2015/11/4/859)
* merge two patches together

Changes from V1: (https://lkml.org/lkml/2015/11/4/857)
* Use do_div to handle the linker errors on i386

Changes from V1: https://lkml.org/lkml/2015/11/4/858
* None

Sinan Kaya (3):
  scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
  scsi: fix compiler warning for sg
  scsi: mptxsas: offload IRQ execution

 drivers/scsi/mpt2sas/mpt2sas_base.c | 33 ++++++++++++++++++++++++++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c | 35 ++++++++++++++++++++++++++++++-----
 drivers/scsi/sg.c                   | 20 +++++++++++++-------
 3 files changed, 71 insertions(+), 17 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
