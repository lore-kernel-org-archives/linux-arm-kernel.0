From: elder@linaro.org (Alex Elder)
Date: Tue, 25 Feb 2014 18:15:52 -0600
Subject: [PATCH v2 12/12] ARM: dts: add bus clock bsc3_apb for bcm281xx
In-Reply-To: <1393373752-30875-1-git-send-email-elder@linaro.org>
References: <1393373752-30875-1-git-send-email-elder@linaro.org>
Message-ID: <1393373752-30875-13-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the bus clock named "bsc3_apb" to the list of those provided by
the slave CCU.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 94b36f6..ff56891 100644
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
1.7.9.5
