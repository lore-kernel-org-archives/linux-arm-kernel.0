From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Nov 2014 09:51:14 +0900
Subject: [PATCH 3/4] ARM: shmobile: koelsch: Use keyboard as gpio-keys node
 name
In-Reply-To: <cover.1416271777.git.horms+renesas@verge.net.au>
References: <cover.1416271777.git.horms+renesas@verge.net.au>
Message-ID: <d3aaec8365c72925645260d3a474140a06a267f4.1416271777.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This appears to be the best match for ePAPR.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 9497cc2..a903185 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -44,7 +44,7 @@
 		#size-cells = <1>;
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		key-1 {
-- 
2.1.1
