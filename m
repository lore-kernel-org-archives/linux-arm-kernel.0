From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 17 Jan 2018 19:32:44 +0100
Subject: [PATCH 4/4] MAINTAINERS: add i.MX8 DT path to i.MX architecture
In-Reply-To: <20180117183244.28303-1-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
Message-ID: <20180117183244.28303-4-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn agreed to take patches for the i.MX8 parts through his tree.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 18994806e441..c51d1e15c386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1390,6 +1390,7 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	arch/arm64/boot/dts/nxp/
 F:	drivers/clk/imx/
 F:	drivers/soc/imx/
 F:	include/soc/imx/
-- 
2.11.0
