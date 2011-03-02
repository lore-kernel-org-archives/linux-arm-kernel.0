From: kheitke@codeaurora.org (Kenneth Heitke)
Date: Tue,  1 Mar 2011 21:01:03 -0700
Subject: [PATCH v3 0/2] msm: add single-wire serial bus interface (SSBI) driver
Message-ID: <1299038465-11782-1-git-send-email-kheitke@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch history
v3: move SSBI driver to drivers/platform/msm
v2: move SSBI driver to drivers//msm from arch/arm/mach-msm

Kenneth Heitke (2):
  MAINTAINERS: Add drivers/platform/msm to MSM subsystem
  platform-drivers: msm: add single-wire serial bus interface (SSBI)
    driver

 MAINTAINERS                   |    1 +
 drivers/platform/Kconfig      |    3 +
 drivers/platform/Makefile     |    1 +
 drivers/platform/msm/Kconfig  |   13 ++
 drivers/platform/msm/Makefile |    4 +
 drivers/platform/msm/ssbi.c   |  396 +++++++++++++++++++++++++++++++++++++++++
 include/linux/msm_ssbi.h      |   49 +++++
 7 files changed, 467 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/msm/Kconfig
 create mode 100644 drivers/platform/msm/Makefile
 create mode 100644 drivers/platform/msm/ssbi.c
 create mode 100644 include/linux/msm_ssbi.h

-- 
1.7.3.3

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
