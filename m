From: mars.cheng@mediatek.com (Mars Cheng)
Date: Tue, 30 Jun 2015 15:02:29 +0800
Subject: [PATCH v2 0/2] Add mt6580 basic chip support
Message-ID: <1435647751-20422-1-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add basic support for Mediatek's new 4-core chip, mt6580.

Change in v2:
1. Use stdout-path in device tree to indicate console
2. Remove board-specific bootargs

Mars Cheng (2):
  Document: DT: Add bindings for mediatek MT6580 SoC Platform
  ARM: dts: mediatek: add 6580 support

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mt6580-evbp1.dts                 |  35 ++++++
 arch/arm/boot/dts/mt6580.dtsi                      | 125 +++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt6580-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt6580.dtsi

--
1.8.1.1.dirty
