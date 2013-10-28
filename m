From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Oct 2013 10:00:43 +0100
Subject: [PATCH v6 8/8] ARM: imx27: enable pinctrl
In-Reply-To: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1382950843-26066-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6..58726d5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -121,6 +121,8 @@ config SOC_IMX27
 	select IMX_HAVE_IOMUX_V1
 	select MACH_MX27
 	select MXC_AVIC
+	select PINCTRL
+	select PINCTRL_IMX27
 
 config SOC_IMX31
 	bool
-- 
1.8.4.rc3
