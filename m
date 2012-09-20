From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:46 +0200
Subject: [PATCH 28/32] ARM: ux500: Add nodes for the MSP into the HREF Device
 Tree
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-29-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the two important MSP devices for ST-Ericsson's
hardware reference development board.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 1d2c642..62ba5e8 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -61,5 +61,13 @@
 				reg = <0x33>;
 			};
 		};
+
+		msp1: msp at 80124000 {
+			status = "okay";
+		};
+
+		msp3: msp at 80125000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
