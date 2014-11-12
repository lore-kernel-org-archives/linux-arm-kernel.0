From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 17:59:34 +0900
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Use keyboard as gpio-keys
 node name
In-Reply-To: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
References: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1415782777-4729-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to be the best match for ePAPR.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 98504e0..d4af4d8 100644
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
