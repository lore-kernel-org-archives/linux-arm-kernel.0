From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Oct 2012 16:18:53 +0100
Subject: [PATCH 4/6] ARM: ux500: Add UART support to the u9540 Device Tree
In-Reply-To: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349882335-6786-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 3 UART nodes required to enable serial ports on the u9540.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/u9540.dts |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
index 0a66f34..28efe20 100644
--- a/arch/arm/boot/dts/u9540.dts
+++ b/arch/arm/boot/dts/u9540.dts
@@ -21,6 +21,17 @@
 	};
 
 	soc-u9500 {
-	};
 
+		uart at 80120000 {
+			status = "okay";
+		};
+
+		uart at 80121000 {
+			status = "okay";
+		};
+
+		uart at 80007000 {
+			status = "okay";
+		};
+	};
 };
-- 
1.7.9.5
