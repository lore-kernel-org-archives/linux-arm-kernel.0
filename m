From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Wed, 4 May 2016 11:24:33 +0800
Subject: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
In-Reply-To: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer entry for Freescale SoC driver including
the QE library and the GUTS driver now. Also add maintainer
for QE library.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v8:
	- Added this patch
Changes for v9:
	- Added linux-arm mail list
	- Removed GUTS driver entry
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42e65d1..ce91db7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4622,9 +4622,18 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
 F:	drivers/net/ethernet/freescale/fec.h
 F:	Documentation/devicetree/bindings/net/fsl-fec.txt
 
+FREESCALE SOC DRIVER
+M:	Scott Wood <oss@buserror.net>
+L:	linuxppc-dev at lists.ozlabs.org
+L:	linux-arm-kernel at lists.infradead.org
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
-- 
2.1.0.27.g96db324
