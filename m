From: elder@linaro.org (Alex Elder)
Date: Mon,  5 May 2014 08:57:36 -0500
Subject: [PATCH 5/5] ARM: dts: add bus clock bsc3_apb for bcm281xx
In-Reply-To: <1399298256-10965-1-git-send-email-elder@linaro.org>
References: <1399298256-10965-1-git-send-email-elder@linaro.org>
Message-ID: <1399298256-10965-6-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the bus clock named "bsc3_apb" to the list of those provided by
the slave CCU.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 64d069b..faff8af 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -247,7 +247,8 @@
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "pwm";
+					     "pwm",
+					     "bsc3_apb";
 		};
 
 		ref_1m_clk: ref_1m {
-- 
1.9.1
