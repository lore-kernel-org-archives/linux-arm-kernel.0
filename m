From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 18 Feb 2011 18:18:25 +0100
Subject: [PATCH 0/2] mach-mxs: dynamic device creation for i.MX28-i2c
Message-ID: <1298049507-6987-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently for mx28 only, because the driver submitted for mainline does only
PIOQUEUE which is only available on that cpu. mx23 can be added if support is
available.

Patches are based on imx-for-2.6.39.

Wolfram Sang (2):
  arm: mx23: names of interrupts and base address should match for I2C
  arm: mxs: add i2c-devices

 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-i2c.c        |   56 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    9 ++++
 arch/arm/mach-mxs/include/mach/mx23.h           |    2 +-
 6 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-i2c.c

-- 
1.7.2.3
