From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:29:23 +0100
Subject: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of the A10 watchdog compatible changes.
The only difference with the v1 being that we're now droping the old
compatibles, instead of keeping them, since the DT maintainers said it was
fine.

Thanks,
Maxime

Maxime Ripard (3):
  watchdog: sunxi: Change compatibles
  ARM: sunxi: Add the new watchog compatibles to the reboot code
  ARM: sunxi: dt: Update the watchdog compatibles

 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 6 +++---
 arch/arm/boot/dts/sun4i-a10.dtsi                         | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                        | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                         | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                         | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                         | 2 +-
 arch/arm/mach-sunxi/sunxi.c                              | 4 ++--
 drivers/watchdog/sunxi_wdt.c                             | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.8.4.2
