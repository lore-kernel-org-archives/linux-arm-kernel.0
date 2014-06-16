From: elder@linaro.org (Alex Elder)
Date: Mon, 16 Jun 2014 08:40:07 -0500
Subject: [PATCH v6 7/7] ARM: dts: add bus clock bsc3_apb for bcm281xx
In-Reply-To: <1402926007-4436-1-git-send-email-elder@linaro.org>
References: <1402926007-4436-1-git-send-email-elder@linaro.org>
Message-ID: <1402926007-4436-8-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the bus clock named "bsc3_apb" to the list of those provided by
the slave CCU.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 6b05ae6..c8977dc 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -255,7 +255,8 @@
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
