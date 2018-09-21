From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 21 Sep 2018 14:56:26 +0200
Subject: [PATCh v3 4/4] MAINTAINERS: add i.MX8 DT path to i.MX architecture
In-Reply-To: <20180921125626.21971-1-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
Message-ID: <20180921125626.21971-4-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn agreed to take patches for the i.MX8 parts through his tree.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..f080df859941 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1461,6 +1461,7 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	arch/arm64/boot/dts/freescale/imx*
 F:	drivers/clk/imx/
 F:	drivers/soc/imx/
 F:	include/soc/imx/
-- 
2.19.0
