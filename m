From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 08:41:07 +0200
Subject: remove several ARCH_MX* macros
Message-ID: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_MX* and MACH_MX* macros a scheduled for removal for
longer. This series removes several of them in drivers/

Sascha Hauer (5):
      mmc i.MX: remove individual SoC dependency
      dma i.MX: remove individual SOC dependency
      USB host i.MX21: remove dependency on MACH_MX21
      USB gadget i.MX1: remove dependency on ARCH_MXC
      media i.MX1 camera: remove dependency on ARCH_MX1

 drivers/dma/Kconfig         |    6 +++---
 drivers/media/video/Kconfig |    2 +-
 drivers/mmc/host/Kconfig    |   12 ++++++------
 drivers/usb/gadget/Kconfig  |    9 ++++-----
 drivers/usb/host/Kconfig    |    6 +++---
 5 files changed, 17 insertions(+), 18 deletions(-)
