From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Fri, 28 Apr 2017 04:50:34 -0500
Subject: [PATCH v3 9/9] staging: fsl-dpaa2/eth: Add maintainer for Ethernet
 driver
In-Reply-To: <20170428095034.8842-1-ruxandra.radulescu@nxp.com>
References: <20170428095034.8842-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170428095034.8842-10-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
v3: no changes
v2: Remove "Freescale" from the driver name 

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b38b42f96e6a..4368f67bb261 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4109,6 +4109,12 @@ L:	linux-kernel at vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-mc/bus/dpio
 
+DPAA2 ETHERNET DRIVER
+M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/staging/fsl-dpaa2/ethernet
+
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi at vger.kernel.org
-- 
2.11.0
