From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  1 Sep 2013 09:28:08 +0200
Subject: [PATCH v3 7/7] ARM: imx27: enable pinctrl
In-Reply-To: <1378020488-21129-1-git-send-email-mpa@pengutronix.de>
References: <1378020488-21129-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1378020488-21129-8-git-send-email-mpa@pengutronix.de>
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
1.8.4.rc3
