From: vishalm@ti.com (Vishal Mahaveer)
Date: Tue, 25 Aug 2015 16:50:50 -0500
Subject: [PATCH] ARM: dts: DRA7: fix a typo in ethernet
Message-ID: <1440539450-8393-1-git-send-email-vishalm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register address in name of the node is wrong

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1e29ccf..9a20d46 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1398,7 +1398,7 @@
 			ti,irqs-safe-map = <0>;
 		};
 
-		mac: ethernet at 4a100000 {
+		mac: ethernet at 48484000 {
 			compatible = "ti,cpsw";
 			ti,hwmods = "gmac";
 			clocks = <&dpll_gmac_ck>, <&gmac_gmii_ref_clk_div>;
-- 
1.7.4.1
