From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:28 +0900
Subject: [PATCH 5/5] ARM: shmobile: kzm9g-reference dts: Use tabs for
 indentation
In-Reply-To: <cover.1409792871.git.horms+renesas@verge.net.au>
References: <cover.1409792871.git.horms+renesas@verge.net.au>
Message-ID: <40c488df84f9fbf4b84b4baed6e2cec4a2d946ed.1409792871.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Checkpatch says:

ERROR: code indent should use tabs where possible

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 18662ae..477f815 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -66,7 +66,7 @@
 	};
 
 	vmmc_sdhi0: regulator at 2 {
-	        compatible = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "SDHI0 Vcc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -75,7 +75,7 @@
 	};
 
 	vmmc_sdhi2: regulator at 3 {
-	        compatible = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "SDHI2 Vcc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
2.0.1
