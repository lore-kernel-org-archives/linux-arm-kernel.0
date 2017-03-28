From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Tue, 28 Mar 2017 15:24:26 -0400
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: change switch2 label
Message-ID: <20170328192426.13798-1-vivien.didelot@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the switch2 at 0 label of the switch2 node to switch at 0 to respect
the general unit at address DTS rule, and be consistent with the other
switch nodes of the DTS file.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 7940408838df..5a93f2d875b1 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -239,7 +239,7 @@
 			#size-cells = <0>;
 			reg = <4>;
 
-			switch2: switch2 at 0 {
+			switch2: switch at 0 {
 				compatible = "marvell,mv88e6085";
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.12.1
