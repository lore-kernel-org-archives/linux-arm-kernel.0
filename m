From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu,  9 Jan 2014 17:47:56 +0100
Subject: [PATCH 02/18] ARM: dts: omap3-tobi: Use the correct vendor prefix
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1389286092-27087-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gumstix is the correct vendor for all Overo related products.

Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 7e4ad2a..9fe10ca 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
-	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3";
+	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap3";
 
 	leds {
 		compatible = "gpio-leds";
-- 
1.8.1.2
