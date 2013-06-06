From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:16:56 +0100
Subject: [PATCH 08/33] ARM: ux500: Add PRCC Kernel clock node to DBx500 Device
 Tree
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index d3cc575c..d682ea0 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -53,6 +53,10 @@
 			prcc_pclk: prcc-periph-clock {
 				#clock-cells = <2>;
 			};
+
+			prcc_kclk: prcc-kernel-clock {
+				#clock-cells = <2>;
+			};
 		};
 
 		timer at a0410600 {
-- 
1.7.10.4
