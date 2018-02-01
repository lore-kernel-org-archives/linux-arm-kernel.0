From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu,  1 Feb 2018 19:31:26 +0100
Subject: [PATCH v2 4/4] MAINTAINERS: add i.MX8 DT path to i.MX architecture
In-Reply-To: <20180201183126.32384-1-l.stach@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
Message-ID: <20180201183126.32384-4-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn agreed to take patches for the i.MX8 parts through his tree.
Also add the NXP Linux team as a reviewer.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..5e1f413d9ae5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1382,6 +1382,7 @@ ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
 M:	Sascha Hauer <kernel@pengutronix.de>
 R:	Fabio Estevam <fabio.estevam@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
@@ -1389,6 +1390,7 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	arch/arm64/boot/dts/freescale/imx*
 F:	drivers/clk/imx/
 F:	drivers/soc/imx/
 F:	include/soc/imx/
-- 
2.15.1
