From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Nov 2014 09:51:12 +0900
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Use keyboard as gpio-keys
 node name
In-Reply-To: <cover.1416271777.git.horms+renesas@verge.net.au>
References: <cover.1416271777.git.horms+renesas@verge.net.au>
Message-ID: <04a5656fbcc960a519674f05d5458e6013d67467.1416271777.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to be the best match for ePAPR.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2703428..e183a33 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -78,7 +78,7 @@
 		regulator-boot-on;
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		power-key {
-- 
2.1.1
