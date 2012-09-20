From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:32 +0200
Subject: [PATCH 14/32] ARM: ux500: Add UART support to the HREF Device Tree
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add three nodes enabling UART support on the HREF hardware
reference board.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 96bf8a3..32cd7a0 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -21,6 +21,16 @@
 	};
 
 	soc-u9500 {
+		uart at 80120000 {
+			status = "okay";
+		};
 
+		uart at 80121000 {
+			status = "okay";
+		};
+
+		uart at 80007000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
