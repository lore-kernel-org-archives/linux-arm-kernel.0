From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 1 Nov 2016 11:02:22 +0800
Subject: [PATCH 2/3] ARM: imx: mach-imx6ul: add imx6ull support
In-Reply-To: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1477969343-19887-3-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6ull is derived SoC from imx6ul.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 58a2b88..0b24630 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -89,10 +89,11 @@ static void __init imx6ul_init_late(void)
 
 static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
+	"fsl,imx6ull",
 	NULL,
 };
 
-DT_MACHINE_START(IMX6UL, "Freescale i.MX6 Ultralite (Device Tree)")
+DT_MACHINE_START(IMX6UL, "Freescale i.MX6 UltraLite (Device Tree)")
 	.init_irq	= imx6ul_init_irq,
 	.init_machine	= imx6ul_init_machine,
 	.init_late	= imx6ul_init_late,
-- 
2.7.4
