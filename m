From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  1 Mar 2016 00:44:17 +0100
Subject: [PATCH 0/8] ARM64: meson: GXBaby (S905) and Vega S95 enablement
Message-ID: <1456789465-2962-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for the Amlogic S905 based
Tronsmart Vega S95 Pro, Meta and Telos TV boxes.

Regards,
Andreas

Cc: devicetree at vger.kernel.org

Andreas F?rber (8):
  ARM64: Enable Amlogic Meson GXBaby platform
  Documentation: devicetree: amlogic: Document Meson GXBaby
  ARM64: dts: Prepare configs for Amlogic Meson GXBaby
  Documentation: devicetree: Document Tronsmart vendor prefix
  Documentation: devicetree: amlogic: Document Tronsmart Vega S95 boards
  ARM64: dts: amlogic: Add Tronsmart Vega S95 configs
  ARM64: dts: amlogic: Extend GXBaby GIC node
  ARM64: dts: amlogic: Add arch timer node for Meson GXBaby

 Documentation/devicetree/bindings/arm/amlogic.txt  |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   7 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  55 ++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  55 ++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  55 ++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  73 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 142 +++++++++++++++++++++
 10 files changed, 402 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/Makefile
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi

-- 
2.6.2
