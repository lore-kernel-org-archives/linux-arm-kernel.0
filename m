From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Fri, 1 Jun 2012 12:44:13 +0800
Subject: [PATCHv2 0/3] omap3 and omap4: add device tree support for wdt
Message-ID: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiao Jiang <jgq516@gmail.com>

Changes compared to previous version:
- created document for omap wdt
- some modifications per the comments from Benoit and Jon

This series is based on latest Linus'tree, and also can be applied to dt branch
of linux-omap tree. Tested with omap4430 blaze board and am37xx board.

Xiao Jiang (3):
  arm/dts: add wdt node for omap3 and omap4
  OMAP: avoid build wdt platform device if with dt support
  watchdog: omap_wdt: add device tree support

 .../devicetree/bindings/watchdog/omap-wdt.txt      |   14 ++++++++++++++
 arch/arm/boot/dts/omap3.dtsi                       |    5 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 +++++
 arch/arm/mach-omap2/devices.c                      |    2 +-
 drivers/watchdog/omap_wdt.c                        |    7 +++++++
 5 files changed, 32 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/omap-wdt.txt

-- 
1.7.3
