From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:09 +0300
Subject: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
Message-ID: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a bitmap that indicates which HardWare Accelerators(HWA) are
supported on Tegra114 SoC.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 1f45cf5..715b5d6 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -323,7 +323,7 @@
 		       0x70019228 0x074>;
 		nvidia,#asids = <4>;
 		dma-window = <0 0x40000000>;
-		nvidia,swgroups = <0x18659fe>;
+		nvidia,swgroups = <0x00000000 0x01b659fe>;
 		nvidia,ahb = <&ahb>;
 	};
 
-- 
1.8.1.5
