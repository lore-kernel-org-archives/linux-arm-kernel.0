From: vigneshr@ti.com (Vignesh R)
Date: Tue, 16 Dec 2014 14:52:51 +0530
Subject: [PATCH 2/2] ARM: dts: DRA7X: drop id property in pcie_phy
In-Reply-To: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
References: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
Message-ID: <1418721771-31184-3-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since phyid is no longer used by pcie driver, this field can be dropped
from the DT.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 63bf99be1762..889e3023e68f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1111,7 +1111,6 @@
 					      "wkupclk", "refclk",
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
-				id = <1>;
 				ti,hwmods = "pcie1-phy";
 			};
 
@@ -1132,7 +1131,6 @@
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
 				ti,hwmods = "pcie2-phy";
-				id = <2>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1
