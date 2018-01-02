From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:52 +0100
Subject: [PATCH v2 2/8] arm64: dts: marvell: use lower case for unit address
 and reg property
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-3-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following DTC warning:

  <stdout>: Warning (simple_bus_reg): Node /ap806/config-space at f0000000/thermal at 6f808C simple-bus unit address format error, expected "6f808c"

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 36f6d7fbb310..0575207cafee 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -286,9 +286,9 @@
 				};
 			};
 
-			ap_thermal: thermal at 6f808C {
+			ap_thermal: thermal at 6f808c {
 				compatible = "marvell,armada-ap806-thermal";
-				reg = <0x6f808C 0x4>,
+				reg = <0x6f808c 0x4>,
 				      <0x6f8084 0x8>;
 			};
 		};
-- 
2.14.3
