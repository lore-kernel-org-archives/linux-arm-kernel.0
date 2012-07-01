From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun,  1 Jul 2012 22:46:05 +0200
Subject: [PATCH 2/2] arm: mxs: enable flexcan on imx28
In-Reply-To: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
References: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1341175565-13218-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 91cf062..ccdf83b 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -16,6 +16,7 @@ config SOC_IMX28
 	bool
 	select ARM_AMBA
 	select CPU_ARM926T
+	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_PWM
 	select PINCTRL_IMX28
 
-- 
1.7.10
