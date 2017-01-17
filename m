From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 17 Jan 2017 17:24:08 +0800
Subject: [PATCH v3] Add some DT nodes for Mediatek MT2701 
Message-ID: <1484645049-4477-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.10-rc2, include MT2701 spi/nand/auxadc/thermal controller DT nodes.

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

Change in v3:
1. Since some patches in v2 have been applied to v4.10-next/dts32, they were not included in v3 series.
2. Remove iommu DT nodes since it will be sent with its driver patch series later.
3. Remove ethernet DT nodes since it will be sent with its driver patch series later.
4. Modify thermal resets pin define from hard code to name.

Change in v2:
1. Add spi/auxadc pin setting
2. Add ethernet node and pin setting
3. Add thermal controller node

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Dawei Chien (1):
  arm: dts: mt2701: Add thermal device node.

 arch/arm/boot/dts/mt2701.dtsi | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--
1.9.1
