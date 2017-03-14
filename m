From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Mar 2017 08:05:40 -0700
Subject: [PATCH v5 3/3] ARM: imx: select IMX7_PM_DOMAINS for SOC_IMX7D
In-Reply-To: <20170314150540.27831-1-andrew.smirnov@gmail.com>
References: <20170314150540.27831-1-andrew.smirnov@gmail.com>
Message-ID: <20170314150540.27831-4-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: yurovsky at gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 936c59d..1b7d9a2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -536,6 +536,7 @@ config SOC_IMX7D
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select IMX7_PM_DOMAINS if PM
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
-- 
2.9.3
