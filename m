From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:34 +0200
Subject: [PATCH 25/32] dt-gpio-fix
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-26-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

---
 arch/arm/boot/dts/bcm283x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 170d620..30e6f46 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -293,12 +293,12 @@
 				brcm,pins = <19>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
-			uart1_gpio30: uart1_gpio30 {
-				brcm,pins = <30 31>;
+			uart1_gpio32: uart1_gpio32 {
+				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
-			uart1_ctsrts_gpio32: uart1_ctsrts_gpio32 {
-				brcm,pins = <32 33>;
+			uart1_ctsrts_gpio30: uart1_ctsrts_gpio30 {
+				brcm,pins = <30 31>;
 				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
 			uart1_gpio40: uart1_gpio40 {
-- 
1.8.3.1
