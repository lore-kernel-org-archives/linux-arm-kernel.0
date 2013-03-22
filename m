From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 15:23:35 +0100
Subject: [PATCH 3/4] ARM: at91/trivial: fix model name for SAM9G15-EK
In-Reply-To: <cover.1363960549.git.nicolas.ferre@atmel.com>
References: <cover.1363960549.git.nicolas.ferre@atmel.com>
Message-ID: <9c592c90cf8b8ed46073e46be36cecac1a8f5256.1363960549.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> # 3.8+
---
 arch/arm/boot/dts/at91sam9g15ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9g15ek.dts b/arch/arm/boot/dts/at91sam9g15ek.dts
index 86dd3f6..5427b2d 100644
--- a/arch/arm/boot/dts/at91sam9g15ek.dts
+++ b/arch/arm/boot/dts/at91sam9g15ek.dts
@@ -11,6 +11,6 @@
 /include/ "at91sam9x5ek.dtsi"
 
 / {
-	model = "Atmel AT91SAM9G25-EK";
+	model = "Atmel AT91SAM9G15-EK";
 	compatible = "atmel,at91sam9g15ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
 };
-- 
1.8.0
