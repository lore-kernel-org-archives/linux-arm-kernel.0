From: plaes@plaes.org (Priit Laes)
Date: Wed, 23 Sep 2015 10:38:33 +0300
Subject: [PATCH v2 3/4] ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of
 reg_vcc3v0
In-Reply-To: <1442993914-20295-1-git-send-email-plaes@plaes.org>
References: <1442993914-20295-1-git-send-email-plaes@plaes.org>
Message-ID: <1442993914-20295-4-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ADC seems to be using ldo2 for reference voltage.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 155b11a..b7cab72 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -112,7 +112,7 @@
 };
 
 &lradc {
-	vref-supply = <&reg_vcc3v0>;
+	vref-supply = <&reg_ldo2>;
 
 	status = "okay";
 
-- 
2.5.3
