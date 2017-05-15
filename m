From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 15 May 2017 08:03:50 -0700
Subject: [PATCH v3 2/7] ARM: imx: Select GPCv2 for i.MX7
In-Reply-To: <20170515145305.4465-1-andrew.smirnov@gmail.com>
References: <20170515145305.4465-1-andrew.smirnov@gmail.com>
Message-ID: <20170515150350.7091-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPCv2 IP block is a part of i.MX7 SoC. Select it to make corresponding
driver availible to support DT changes following this patch.

Cc: yurovsky at gmail.com
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 936c59d..782699e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -536,6 +536,7 @@ config SOC_IMX7D
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select IMX_GPCV2
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
-- 
2.9.3
