From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:17:03 +0100
Subject: [PATCH 15/33] ARM: ux500: Add TWD (fixed-factor) clock node to DBx500
 Device Tree
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index edb53c63..2027929 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -61,6 +61,10 @@
 			rtc_clk: rtc32k-clock {
 				#clock-cells = <0>;
 			};
+
+			smp_twd_clk: smp-twd-clock {
+				#clock-cells = <0>;
+			};
 		};
 
 		timer at a0410600 {
-- 
1.7.10.4
