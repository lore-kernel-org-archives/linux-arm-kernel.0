From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:59 +0900
Subject: [PATCH 25/69] ARM: shmobile: ape6evm: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <eeafbdf3253f23cbd30ee5f876ee9bb696a3c207.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 9443e93..25dbc1c 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -88,22 +88,22 @@
 	pinctrl-0 = <&scifa0_pins>;
 	pinctrl-names = "default";
 
-	scifa0_pins: scifa0 {
+	scifa0_pins: serial0 {
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
 	};
 
-	mmc0_pins: mmcif {
+	mmc0_pins: mmc {
 		renesas,groups = "mmc0_data8", "mmc0_ctrl";
 		renesas,function = "mmc0";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
 		renesas,function = "sdhi0";
 	};
 
-	sdhi1_pins: sdhi1 {
+	sdhi1_pins: sd1 {
 		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
 		renesas,function = "sdhi1";
 	};
-- 
1.8.4
