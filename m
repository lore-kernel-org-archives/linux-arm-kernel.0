From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 03:17:29 +0100
Subject: [PATCH v2 00/10] ARM64: rockchip: Initial GeekBox enablement
Message-ID: <1454897859-7601-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for the RK3368 based GeekBox.

v2 drops the .dtsi for the module, adds some nodes and a Landingship config.

This is pretty much the state demo'ed at FOSDEM 2016.

Regards,
Andreas

Cc: devicetree at vger.kernel.org

Andreas F?rber (10):
  Documentation: devicetree: Add vendor prefix for GeekBuying.com
  Documentation: devicetree: rockchip: Document GeekBox
  ARM64: dts: rockchip: Add GeekBox config
  ARM64: dts: rockchip: Add GMAC to GeekBox
  ARM64: dts: rockchip: Add eMMC to GeekBox
  ARM64: dts: rockchip: Add IR receiver to GeekBox
  ARM64: dts: rockchip: Add power key to GeekBox
  ARM64: dts: rockchip: Add tsadc for GeekBox
  Documentation: devicetree: rockchip: Document Landingship
  ARM64: dts: rockchip: Add Landingship config

 Documentation/devicetree/bindings/arm/rockchip.txt |   9 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 .../dts/rockchip/rk3368-geekbox-landingship.dts    |  56 ++++
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    | 321 +++++++++++++++++++++
 5 files changed, 389 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-geekbox-landingship.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts

-- 
2.6.2
