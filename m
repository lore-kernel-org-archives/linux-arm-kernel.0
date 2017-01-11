From: erin.lo@mediatek.com (Erin Lo)
Date: Wed, 11 Jan 2017 16:38:40 +0800
Subject: [PATCH 0/4] Add spi/iommu/nand/auxadc DT nodes for Mediatek MT2701
Message-ID: <1484123924-8946-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series base on v4.10-rc2, include MT2701 spi/iommu/nand/auxadc DT nodes.

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Honghui Zhang (1):
  arm: dts: mt2701: Add iommu/smi device node

Leilk Liu (1):
  arm: dts: mt2701: Add spi device node

Xiaolei Li (1):
  arm: dts: mt2701: Add nand device node

Zhiyong Tao (1):
  arm: dts: mt2701: Add auxadc device node.

 arch/arm/boot/dts/mt2701.dtsi | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

--
1.9.1
