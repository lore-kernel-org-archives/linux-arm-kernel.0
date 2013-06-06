From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:13:19 +0100
Subject: [PATCH 03/32] ARM: ux500: Add PRCC Peripheral clock node to DBx500
 Device Tree
In-Reply-To: <1370520828-31165-1-git-send-email-lee.jones@linaro.org>
References: <1370520828-31165-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370520828-31165-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index c5f187b..18c5c27 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -49,6 +49,10 @@
 			prcmu_clk: prcmu-clock {
 				#clock-cells = <1>;
 			};
+
+			prcc_pclk: prcc-periph-clock {
+				#clock-cells = <2>;
+			};
 		};
 
 		timer at a0410600 {
-- 
1.7.10.4
