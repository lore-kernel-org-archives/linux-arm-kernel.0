From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:35 +0900
Subject: [PATCH 1/7] ARM: shmobile: genmai dts: Replace status value "ok" by
 "okay"
In-Reply-To: <cover.1419809027.git.horms+renesas@verge.net.au>
References: <cover.1419809027.git.horms+renesas@verge.net.au>
Message-ID: <5f61ffb5cfd516c62bae69535e28b0085210b3ae.1419809027.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 1518c5b..a9da7a8 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -45,7 +45,7 @@
 };
 
 &mtu2 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c2 {
-- 
2.1.3
