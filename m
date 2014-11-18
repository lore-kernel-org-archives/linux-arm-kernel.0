From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Nov 2014 09:51:13 +0900
Subject: [PATCH 2/4] ARM: shmobile: lager: Use keyboard as gpio-keys node name
In-Reply-To: <cover.1416271777.git.horms+renesas@verge.net.au>
References: <cover.1416271777.git.horms+renesas@verge.net.au>
Message-ID: <54caf6810327451ea814fd728c45c99755252237.1416271777.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to be the best match for ePAPR.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 854c13e..7012354 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -43,7 +43,7 @@
 		#size-cells = <1>;
 	};
 
-	gpio_keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		button at 1 {
-- 
2.1.1
