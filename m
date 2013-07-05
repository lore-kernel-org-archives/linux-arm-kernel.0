From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:41 +0300
Subject: [PATCH v2 06/22] ARM: dt: tegra114: iommu: Fix IOMMU register address
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-7-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix IOMMU register address.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |    6 +++---
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
1.7.9.5
