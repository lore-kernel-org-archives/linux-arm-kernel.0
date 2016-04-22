From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 22 Apr 2016 14:27:43 +0800
Subject: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific driver
In-Reply-To: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer entry for Freescale SoC specific driver including
the QE library and the GUTS driver. Also add entry for GUTS driver
and add maintainer for QE library.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v8:
	- Added this patch
---
 MAINTAINERS | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4be..d20aeb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4622,13 +4622,27 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
 F:	drivers/net/ethernet/freescale/fec.h
 F:	Documentation/devicetree/bindings/net/fsl-fec.txt
 
+FREESCALE SOC SPECIFIC DRIVER
+M:	Scott Wood <oss@buserror.net>
+L:	linuxppc-dev at lists.ozlabs.org
+S:	Maintained
+F:	drivers/soc/fsl/
+F:	include/linux/fsl/
+
 FREESCALE QUICC ENGINE LIBRARY
+M:	Qiang Zhao <qiang.zhao@nxp.com>
 L:	linuxppc-dev at lists.ozlabs.org
-S:	Orphan
+S:	Maintained
 F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/*qe*.h
 F:	include/soc/fsl/*ucc*.h
 
+FREESCALE GUTS DRIVER
+M:	Yangbo Lu <yangbo.lu@nxp.com>
+L:	linuxppc-dev at lists.ozlabs.org
+S:	Maintained
+F:	drivers/soc/fsl/guts.c
+
 FREESCALE USB PERIPHERAL DRIVERS
 M:	Li Yang <leoli@freescale.com>
 L:	linux-usb at vger.kernel.org
-- 
2.1.0.27.g96db324
