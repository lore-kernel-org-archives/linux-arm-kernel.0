From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 20 Feb 2015 14:21:14 +0530
Subject: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie phy
In-Reply-To: <1424422274-27946-1-git-send-email-kishon@ti.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
Message-ID: <1424422274-27946-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we don't have hwmod entry for pcie PHY remove the
ti,hwmod property from PCIE PHY's

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5827fed..18a904d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1111,7 +1111,6 @@
 					      "wkupclk", "refclk",
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
-				ti,hwmods = "pcie1-phy";
 			};
 
 			pcie2_phy: pciephy at 4a095000 {
@@ -1130,7 +1129,6 @@
 					      "wkupclk", "refclk",
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
-				ti,hwmods = "pcie2-phy";
 				status = "disabled";
 			};
 		};
-- 
1.7.9.5
