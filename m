From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 18:16:31 -0800
Subject: [PATCH 0/3] Add qcom_defconfig and update msm_defconfig
Message-ID: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have mach-qcom, introduce a qcom_defconfig to match and
update the msm_defconfig to compile a board in mach-msm.

Stephen Boyd (3):
  ARM: config: Add qcom_defconfig
  ARM: msm: Silence readb/writeb warnings due to missing IOMEM()
  ARM: config: Update msm_defconfig

 arch/arm/configs/msm_defconfig                     | 25 +++-------------------
 arch/arm/configs/{msm_defconfig => qcom_defconfig} |  4 +---
 arch/arm/mach-msm/board-trout-gpio.c               |  2 +-
 arch/arm/mach-msm/board-trout.c                    |  2 +-
 arch/arm/mach-msm/board-trout.h                    |  2 +-
 5 files changed, 7 insertions(+), 28 deletions(-)
 copy arch/arm/configs/{msm_defconfig => qcom_defconfig} (97%)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
