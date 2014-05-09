From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri,  9 May 2014 15:05:03 +0200
Subject: [PATCH 2/3] ARM: ux500: Add DT node for ux500 power domains
In-Reply-To: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
References: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1399640704-12289-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-pm at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index e41eedc..29a7013 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -43,6 +43,10 @@
 			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pm_domains: pm_domains0 {
+			compatible = "stericsson,ux500-pm-domains";
+			#power-domain-cells = <1>;
+		};
 
 		clocks {
 			compatible = "stericsson,u8500-clks";
-- 
1.7.9.5
