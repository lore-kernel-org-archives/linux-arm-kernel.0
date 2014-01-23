From: syin@broadcom.com (Sherman Yin)
Date: Thu, 23 Jan 2014 12:44:47 -0800
Subject: [PATCH v2 4/4] Update dtsi with new pinctrl compatible string
In-Reply-To: <1390509887-19278-1-git-send-email-syin@broadcom.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
 <1390509887-19278-1-git-send-email-syin@broadcom.com>
Message-ID: <1390509887-19278-5-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates bcm11351.dtsi with the new compatible string for
the same driver.

Signed-off-by: Sherman Yin <syin@broadcom.com>
Reviewed-by: Matt Porter <mporter@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index dd8e878..6c183f3 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -143,7 +143,7 @@
 	};
 
 	pinctrl at 35004800 {
-		compatible = "brcm,capri-pinctrl";
+		compatible = "brcm,bcm11351-pinctrl";
 		reg = <0x35004800 0x430>;
 	};
 };
-- 
1.7.9.5
