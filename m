From: kheitke@codeaurora.org (Kenneth Heitke)
Date: Thu, 24 Feb 2011 15:19:12 -0700
Subject: [PATCH v2 0/2] msm: add single-wire serial bus interface (SSBI) driver
Message-ID: <1298585954-22422-1-git-send-email-kheitke@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches replace the previous patch by moving the SSBI driver from
the arch/arm/mach-msm directory to drivers/msm.

The MAINTAINERS file is being updated to add the appropriate maintainer
for drivers/msm.

Kenneth Heitke (2):
  MAINTAINERS: Add drivers/msm to MSM subsystem
  msm: add single-wire serial bus interface (SSBI) driver

 MAINTAINERS              |    1 +
 drivers/Kconfig          |    2 +
 drivers/Makefile         |    1 +
 drivers/msm/Kconfig      |   13 ++
 drivers/msm/Makefile     |    4 +
 drivers/msm/ssbi.c       |  376 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msm_ssbi.h |   49 ++++++
 7 files changed, 446 insertions(+), 0 deletions(-)
 create mode 100644 drivers/msm/Kconfig
 create mode 100644 drivers/msm/Makefile
 create mode 100644 drivers/msm/ssbi.c
 create mode 100644 include/linux/msm_ssbi.h

-- 
1.7.3.3

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
