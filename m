From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  9 Feb 2011 14:20:49 +0100
Subject: [PATCH] i.MX23/28 framebuffer driver
Message-ID: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The following patches add framebuffer support for Freescale i.MX23/28
processors.

Sascha Hauer (2):
      video: Add i.MX23/28 framebuffer driver
      ARM i.MX23/28: Add framebuffer device support

 arch/arm/mach-mxs/clock-mx23.c             |    2 +-
 arch/arm/mach-mxs/clock-mx28.c             |    1 +
 arch/arm/mach-mxs/devices-mx23.h           |    4 +
 arch/arm/mach-mxs/devices-mx28.h           |    4 +
 arch/arm/mach-mxs/devices/Kconfig          |    4 +
 arch/arm/mach-mxs/devices/Makefile         |    1 +
 arch/arm/mach-mxs/devices/platform-mxsfb.c |   46 ++
 arch/arm/mach-mxs/include/mach/fb.h        |   48 ++
 drivers/video/Kconfig                      |    9 +
 drivers/video/Makefile                     |    1 +
 drivers/video/mxsfb.c                      |  914 ++++++++++++++++++++++++++++
 11 files changed, 1033 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c
 create mode 100644 arch/arm/mach-mxs/include/mach/fb.h
 create mode 100644 drivers/video/mxsfb.c
