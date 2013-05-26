From: horms+renesas@verge.net.au (Simon Horman)
Date: Sun, 26 May 2013 22:05:57 +0900
Subject: [PATCH 6/6] ARM: shmobile: Remove unused r8a73a4 GIC CPU interface DT
 bits
In-Reply-To: <1369573557-11071-1-git-send-email-horms+renesas@verge.net.au>
References: <1369573557-11071-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369573557-11071-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused GIC CPU interface DT bits for r8a73a4.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index fde2a33..4ff2019 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -37,12 +37,6 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
-
-		gic-cpuif at 4 {
-			compatible = "arm,gic-cpuif";
-			cpuif-id = <4>;
-			cpu = <&cpu0>;
-		};
 	};
 
 	timer {
-- 
1.7.10.4
