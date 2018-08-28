From: peda@axentia.se (Peter Rosin)
Date: Tue, 28 Aug 2018 11:48:42 +0200
Subject: [PATCH 3/5] ARM: dts: at91: nattis: state the actual lvds-encoder chip
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
References: <20180828094844.10018-1-peda@axentia.se>
Message-ID: <20180828094844.10018-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just to be explicit.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 4308a07b792e..fbc796125c56 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -117,7 +117,7 @@
 	};
 
 	lvds-encoder {
-		compatible = "lvds-encoder";
+		compatible = "ti,ds90c185", "lvds-encoder";
 
 		ports {
 			#address-cells = <1>;
-- 
2.11.0
