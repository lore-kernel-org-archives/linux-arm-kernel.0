From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 5 May 2016 11:12:29 +0800
Subject: [v10, 6/7] MAINTAINERS: add entry for Freescale SoC drivers
In-Reply-To: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1462417950-46796-7-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer entry for Freescale SoC drivers including
the QE library and the GUTS driver now. Also add maintainer
for QE library.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Scott Wood <oss@buserror.net>
Acked-by: Qiang Zhao <qiang.zhao@nxp.com>
---
Changes for v8:
	- Added this patch
Changes for v9:
	- Added linux-arm mail list
	- Removed GUTS driver entry
Changes for v10:
	- Changed 'DRIVER' to 'DRIVERS'
	- Added 'Acked-by' of Scott and Qiang
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42e65d1..85c4b8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4622,9 +4622,18 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
 F:	drivers/net/ethernet/freescale/fec.h
 F:	Documentation/devicetree/bindings/net/fsl-fec.txt
 
+FREESCALE SOC DRIVERS
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
