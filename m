From: carlo@caione.org (Carlo Caione)
Date: Fri, 14 Nov 2014 17:38:32 +0100
Subject: [PATCH] DTS: meson: Add forgotten compatible in board DTS
Message-ID: <1415983112-11064-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board DTS is missing the machine compatible.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson6-atv1200.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
index dc2541f..d7d351a 100644
--- a/arch/arm/boot/dts/meson6-atv1200.dts
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
@@ -50,7 +50,7 @@
 
 / {
 	model = "Geniatech ATV1200";
-	compatible = "geniatech,atv1200";
+	compatible = "geniatech,atv1200", "amlogic,meson6";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
1.9.1
