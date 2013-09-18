From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:38 +0100
Subject: [PATCH 41/41] ARM: ux500: Fix trivial whitespace/tabbing issue
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-42-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 0d2d5d0..e93b54c 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -308,7 +308,7 @@
 					     <22 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "IRQ_HOTMON_LOW", "IRQ_HOTMON_HIGH";
 				status = "disabled";
-			 };
+			};
 
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
-- 
1.8.1.2
