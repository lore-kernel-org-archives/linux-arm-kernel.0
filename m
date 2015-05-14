From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:44 +0900
Subject: [PATCH 15/31] ARM: shmobile: ape6evm dts: Use generic names for
 device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <e8545be97479972346a1519412c5330b4223ca20.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

max8973 -> regulator

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 81a38ceee098..a4c425923c05 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -147,7 +147,7 @@
 
 &i2c5 {
 	status = "okay";
-	vdd_dvfs: max8973 at 1b {
+	vdd_dvfs: regulator at 1b {
 		compatible = "maxim,max8973";
 		reg = <0x1b>;
 
-- 
2.1.4
