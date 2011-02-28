From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 09:02:30 +0100
Subject: [PATCH v3] i.MX23/28 Framebuffer support
Message-ID: <1298880152-28913-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Third and hopefully last iteration of these patches.

Sascha

Sascha Hauer (2):
      video: Add i.MX23/28 framebuffer driver
      ARM i.MX23/28: Add framebuffer device support

 arch/arm/mach-mxs/clock-mx23.c             |    1 +
 arch/arm/mach-mxs/clock-mx28.c             |    1 +
 arch/arm/mach-mxs/devices-mx23.h           |    4 +
 arch/arm/mach-mxs/devices-mx28.h           |    4 +
 arch/arm/mach-mxs/devices/Kconfig          |    4 +
 arch/arm/mach-mxs/devices/Makefile         |    1 +
 arch/arm/mach-mxs/devices/platform-mxsfb.c |   46 ++
 arch/arm/mach-mxs/include/mach/mxsfb.h     |   48 ++
 drivers/video/Kconfig                      |    9 +
 drivers/video/Makefile                     |    1 +
 drivers/video/mxsfb.c                      |  914 ++++++++++++++++++++++++++++
 11 files changed, 1033 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c
 create mode 100644 arch/arm/mach-mxs/include/mach/mxsfb.h
 create mode 100644 drivers/video/mxsfb.c
