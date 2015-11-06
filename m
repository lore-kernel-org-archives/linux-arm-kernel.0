From: plaes@plaes.org (Priit Laes)
Date: Fri,  6 Nov 2015 19:54:45 +0200
Subject: [PATCH v3 2/3] ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of
 reg_vcc3v0
In-Reply-To: <1446832486-32319-1-git-send-email-plaes@plaes.org>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
Message-ID: <1446832486-32319-3-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ADC seems to be using ldo2 for reference voltage.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 6b4c29d..16c1a67 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -112,7 +112,7 @@
 };
 
 &lradc {
-	vref-supply = <&reg_vcc3v0>;
+	vref-supply = <&reg_ldo2>;
 
 	status = "okay";
 
-- 
2.6.3
