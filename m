From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 17 Aug 2010 13:23:36 +0200
Subject: [PATCH 0/2] MXC: EPIT Support
Message-ID: <1282044218-14809-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

this patches include support for the "Enhanced Periodic Interrupt Timer"
which can be used as an alternative for the "General Purpose Timer" on
the mx35.

Sascha Hauer (2):
  i.MX: Add EPIT support
  i.MX35: Add EPIT support

 arch/arm/mach-mx3/Kconfig               |    1 +
 arch/arm/mach-mx3/clock-imx35.c         |   13 +-
 arch/arm/plat-mxc/Kconfig               |   12 ++
 arch/arm/plat-mxc/Makefile              |    1 +
 arch/arm/plat-mxc/epit.c                |  243 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 6 files changed, 267 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-mxc/epit.c
