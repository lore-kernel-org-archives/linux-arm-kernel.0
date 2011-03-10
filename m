From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  9 Mar 2011 20:44:31 -0800
Subject: [PATCH 0/3] Peripheral image loader (PIL)
Message-ID: <1299732274-10742-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for PIL, a peripheral image loader.
More details can be found in the third patch or the second
patch's commit text.

Saravana Kannan (1):
  msm: documentation: Add pil documentation

Stephen Boyd (2):
  msm: 8660: Add clock control regions to iomap
  msm: Peripheral Image Loader (PIL) driver

 Documentation/arm/msm/pil.txt                      |  267 ++++++++++
 arch/arm/mach-msm/Kconfig                          |   13 +
 arch/arm/mach-msm/Makefile                         |    2 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |    8 +
 arch/arm/mach-msm/include/mach/peripheral-loader.h |   23 +
 arch/arm/mach-msm/io.c                             |    2 +
 arch/arm/mach-msm/peripheral-loader.c              |  402 +++++++++++++++
 arch/arm/mach-msm/peripheral-loader.h              |   38 ++
 arch/arm/mach-msm/peripheral-reset.c               |  528 ++++++++++++++++++++
 9 files changed, 1283 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/msm/pil.txt
 create mode 100644 arch/arm/mach-msm/include/mach/peripheral-loader.h
 create mode 100644 arch/arm/mach-msm/peripheral-loader.c
 create mode 100644 arch/arm/mach-msm/peripheral-loader.h
 create mode 100644 arch/arm/mach-msm/peripheral-reset.c

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
