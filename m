From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 29 May 2017 20:56:00 +0800
Subject: [PATCH v2 0/4] Add Basic SoC support for MT7622
Message-ID: <cover.1496061587.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v1:
- update SPDX-License-Identifier
- remove next-level-cache property since cache geometry detection was removed since 4.12

This patch set adds basic SoC support for MediaTek MT7622
SoC based on 4.12-rc1.

Sean Wang (4):
  dt-bindings: mediatek: add bindings for MediaTek MT7622 SoC
  arm64: dts: mt7622: add basic nodes to the mt7622.dtsi file
  arm64: dts: mt7622: add dts file for MT7622 reference board variant 1
  arm64: dts: mt7622: group clock DT nodes into separate DT file

 Documentation/devicetree/bindings/arm/mediatek.txt |  4 +
 .../interrupt-controller/mediatek,sysirq.txt       |  3 +-
 .../devicetree/bindings/serial/mtk-uart.txt        |  1 +
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi     | 20 +++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 27 ++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 98 ++++++++++++++++++++++
 7 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-clock.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622.dtsi

-- 
1.9.1
