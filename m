From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 27 Oct 2014 17:41:30 +0100
Subject: [PATCH 0/2] ARM: mediatek: Add watchdog driver
Message-ID: <1414428092-20725-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek SoCs have a watchdog driver. This patch set adds driver and DTS
binding. The driver also implements a restart handler to reboot the SoC.

Matthias Brugger (2):
  watchdog: Add driver for Mediatek mt6589 watchdog
  ARM: mediatek: dts: Add bindings for watchdog

 .../devicetree/bindings/watchdog/mtk-wdt.txt       |  13 +
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/mtk_wdt.c                         | 264 +++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
 create mode 100644 drivers/watchdog/mtk_wdt.c

-- 
1.9.1
