From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 19 Nov 2013 19:43:16 -0500
Subject: [PATCH v2 3/4] keystone: dts: fix typo in the ddr3 pllclk node name
In-Reply-To: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
References: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1384908197-4324-4-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following typo
 ddr3allclk -> ddr3apllclk
 ddr3bllclk -> ddr3bpllclk

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 67e70ec..2a2f247 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -31,7 +31,7 @@ clocks {
 		reg-names = "control";
 	};
 
-	ddr3allclk: ddr3apllclk at 2620360 {
+	ddr3apllclk: ddr3apllclk at 2620360 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
 		clocks = <&refclkddr3a>;
@@ -40,7 +40,7 @@ clocks {
 		reg-names = "control";
 	};
 
-	ddr3bllclk: ddr3bpllclk at 2620368 {
+	ddr3bpllclk: ddr3bpllclk at 2620368 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
 		clocks = <&refclkddr3b>;
-- 
1.7.9.5
