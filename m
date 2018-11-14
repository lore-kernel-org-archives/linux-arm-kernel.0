From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 14 Nov 2018 18:52:40 +0100
Subject: [PATCH v4 4/6] MAINTAINERS: add i.MX8 DT path to i.MX architecture
In-Reply-To: <20181114175242.12468-1-l.stach@pengutronix.de>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
Message-ID: <20181114175242.12468-4-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn agreed to take patches for the i.MX8 parts through his tree.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..c491b90392b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1521,6 +1521,7 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	arch/arm64/boot/dts/freescale/imx*
 F:	drivers/clk/imx/
 F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
-- 
2.19.1
