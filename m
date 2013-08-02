From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  2 Aug 2013 12:38:27 +0200
Subject: [PATCH 7/7] ARM: imx27: enable pinctrl
In-Reply-To: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1375439907-10462-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f7a5ad1..52c5e7e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -120,6 +120,8 @@ config SOC_IMX27
 	select IMX_HAVE_IOMUX_V1
 	select MACH_MX27
 	select MXC_AVIC
+	select PINCTRL
+	select PINCTRL_IMX27
 
 config SOC_IMX31
 	bool
-- 
1.8.3.2
