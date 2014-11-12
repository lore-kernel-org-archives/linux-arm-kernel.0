From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 17:59:37 +0900
Subject: [PATCH 4/4] ARM: shmobile: kzm9g-reference: Use keyboard as gpio-keys
 node name
In-Reply-To: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
References: <1415782777-4729-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1415782777-4729-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to be the best match for ePAPR.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0a34c90..939be12 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -117,7 +117,7 @@
 		};
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		back-key {
-- 
2.1.1
