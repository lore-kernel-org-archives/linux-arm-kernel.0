From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:12 +0100
Subject: [PATCH 15/41] ARM: ux500: Add RTC (fixed-frequency) clock node to
 DBx500 Device Tree
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 8857dd1..77ea36f 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -57,6 +57,10 @@
 			prcc_kclk: prcc-kernel-clock {
 				#clock-cells = <2>;
 			};
+
+			rtc_clk: rtc32k-clock {
+				#clock-cells = <0>;
+			};
 		};
 
 		timer at a0410600 {
-- 
1.8.1.2
