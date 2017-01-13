From: erin.lo@mediatek.com (Erin Lo)
Date: Fri, 13 Jan 2017 16:42:52 +0800
Subject: [PATCH v2 0/6] Add some DT nodes for Mediatek MT2701 
Message-ID: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.10-rc2, include MT2701 spi/iommu/nand/auxadc/ethernet/thermal controller DT nodes.

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

Change in v2:
1. Add spi/auxadc pin setting
2. Add ethernet node and pin setting
3. Add thermal controller node

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Dawei Chien (1):
  arm: dts: mt2701: Add thermal device node.

Honghui Zhang (1):
  arm: dts: mt2701: Add iommu/smi device node

Leilk Liu (1):
  arm: dts: mt2701: Add spi device node

Sean Wang (1):
  arm: dts: mt2701: Add ethernet device node.

Xiaolei Li (1):
  arm: dts: mt2701: Add nand device node

Zhiyong Tao (1):
  arm: dts: mt2701: Add auxadc device node.

 arch/arm/boot/dts/mt2701-evb.dts |  94 +++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 189 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 283 insertions(+)

--
1.9.1
