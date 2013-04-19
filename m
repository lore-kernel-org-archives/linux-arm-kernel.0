From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 19 Apr 2013 11:35:29 +0200
Subject: [PATCH] ARM: at91/sama5d34ek.dts: remove not needed compatibility
 string
Message-ID: <1366364129-15974-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"atmel,sama5ek" compatibility sting does not correspond to a
useful board configuration. This d35ek.dts is the only sama5d3
.dts file affected.

Reported-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d34ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index d2739f8..6bebfcd 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Atmel SAMA5D34-EK";
-	compatible = "atmel,sama5d34ek", "atmel,sama5ek", "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";
+	compatible = "atmel,sama5d34ek", "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";
 
 	ahb {
 		apb {
-- 
1.8.0
