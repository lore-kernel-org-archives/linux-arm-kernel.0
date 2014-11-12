From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 17:59:35 +0900
Subject: [PATCH 2/4] ARM: shmobile: lager: Use keyboard as gpio-keys node name
In-Reply-To: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
References: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1415782777-4729-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to be the best match for ePAPR.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 2f91740..814bde2 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -62,7 +62,7 @@
 		#size-cells = <1>;
 	};
 
-	gpio_keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		button at 1 {
-- 
2.1.1
