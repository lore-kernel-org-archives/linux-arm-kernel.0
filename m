From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 14:42:35 +0200
Subject: [PATCH 8/9] arm: tegra: apalis_t30: fix backlight pwm comment for
 eval board
In-Reply-To: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440765756-1382-9-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the backlight PWM comment as it is actually called PWM_BKL1 rather
than just PWM0.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 37437c6..c832c15 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -180,7 +180,7 @@
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
-		/* PWM0 */
+		/* PWM_BKL1 */
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
-- 
2.4.3
