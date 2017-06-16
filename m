From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 17 Jun 2017 01:06:25 +0800
Subject: [PATCH v5 0/2] Add Basic SoC support for MT7622
Message-ID: <cover.1497631953.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v4:
- redefine the two dummy clocks with the correct frequency
  which is 25MHz and 280MHz respectively.

Changes since v3:
- get rid of those accepted patches
- rebased to branch v4.12-next/dts64 in Matthias' tree
- fixed uart node in dts with two clocks as described in bindings documentation

Changes since v2:
- merge back required basic clock nodes into the .dtsi file
- update the property of interrupts in timer nodes with 2 CPUs

Changes since v1:
- update SPDX-License-Identifier
- remove next-level-cache property since cache geometry detection was removed since 4.12

This patch set adds basic SoC support for MediaTek MT7622
SoC based on 4.12-rc1.

Sean Wang (2):
  arm64: dts: mt7622: add basic nodes to the mt7622.dtsi file
  arm64: dts: mt7622: add dts file for MT7622 reference board variant 1

 arch/arm64/boot/dts/mediatek/Makefile        |   1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  27 +++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 110 +++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622.dtsi

-- 
2.7.4
