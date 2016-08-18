From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 15:11:17 +0200
Subject: [PATCH v2 0/4] ARM: dts: Add support for the WP8548 and mangOH Board
Message-ID: <1471525881-2797-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, and on the open hardware mangOH board WP8548 DTSI, mangOH board DTS
and corresponding dt-bindings..

This patchset depends on pinctrl [merged], clk [merged], pmic [1], arm-soc [merged],
arm-soc-dt [2], patchsets.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

[1] http://lkml.kernel.org/r/1466159704-22774-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1471525661-2563-1-git-send-email-narmstrong at baylibre.com

Changes since v1 at : http://lkml.kernel.org/r/1466160132-24574-1-git-send-email-narmstrong at baylibre.com
 - Dropped USB nodes
 - Dropped sx150x specific attribute

Neil Armstrong (4):
  dt-bindings: vendor-prefixes: Add Sierra Wireless
  dt-bindings: arm: Add Sierra Wireless modules bindings
  ARM: dts: Add Sierra Wireless WP8548 dtsi
  ARM: dts: Add WP8548 based MangOH Green board DTS

 Documentation/devicetree/bindings/arm/swi.txt      |  12 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/swi-wp8548-mangoh-green.dts      | 281 +++++++++++++++++++++
 arch/arm/boot/dts/swi-wp8548.dtsi                  | 170 +++++++++++++
 5 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/swi.txt
 create mode 100644 arch/arm/boot/dts/swi-wp8548-mangoh-green.dts
 create mode 100644 arch/arm/boot/dts/swi-wp8548.dtsi

-- 
1.9.1
