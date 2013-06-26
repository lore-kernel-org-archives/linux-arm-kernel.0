From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:08 +0300
Subject: [PATCH 05/23] ARM: dt: tegra114: iommu: Fix IOMMU register address
Message-ID: <1372238906-9346-6-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix IOMMU register address.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index abf6c40..1f45cf5 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -318,9 +318,9 @@
 
 	iommu {
 		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x074>;
+		reg = <0x70019010 0x02c
+		       0x700191f0 0x010
+		       0x70019228 0x074>;
 		nvidia,#asids = <4>;
 		dma-window = <0 0x40000000>;
 		nvidia,swgroups = <0x18659fe>;
-- 
1.8.1.5
