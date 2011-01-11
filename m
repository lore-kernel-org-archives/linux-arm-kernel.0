From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 16:09:03 +0100
Subject: Add i.MX23/28 auart support
Message-ID: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series adds support for the auart found on i.MX23/28

Sascha Hauer (2):
      serial: Add auart driver for i.MX23/28
      ARM i.MXS: Add auart platform support for i.MX28

 arch/arm/mach-mxs/clock-mx28.c                  |    5 +
 arch/arm/mach-mxs/devices-mx28.h                |    8 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-auart.c      |   54 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 +
 drivers/serial/Kconfig                          |   15 +
 drivers/serial/Makefile                         |    1 +
 drivers/serial/mxs-auart.c                      |  763 +++++++++++++++++++++++
 9 files changed, 860 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
 create mode 100644 drivers/serial/mxs-auart.c
