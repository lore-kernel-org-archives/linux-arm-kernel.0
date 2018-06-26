From: mars.cheng@mediatek.com (Mars Cheng)
Date: Tue, 26 Jun 2018 10:04:04 +0800
Subject: [PATCH 0/2] Add basic SoC support for MT6765
Message-ID: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds basic SoC support for Mediatek's new 8-core SoC,
MT6765, which is mainly for smartphone application.

Change in V2:
1. fix clk properties in uart dts node
2. fix typo in submit title
3. add simple-bus in mt6765.dtsi
4. use correct SPDX license format

Mars Cheng (2):
  dt-bindings: mediatek: Add bindings for mediatek MT6765 Platform
  arm64: dts: mediatek: add mt6765 support

 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt6765-evb.dts        |   33 ++++
 arch/arm64/boot/dts/mediatek/mt6765.dtsi           |  158 ++++++++++++++++++++
 6 files changed, 198 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
