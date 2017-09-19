From: razvan.stefanescu@nxp.com (Razvan Stefanescu)
Date: Tue, 19 Sep 2017 12:01:36 +0300
Subject: [PATCH 4/6] staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet
 Switch driver
In-Reply-To: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
References: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
Message-ID: <1505811698-7338-5-git-send-email-razvan.stefanescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2281af4..cfd4f74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4297,6 +4297,12 @@ L:	linux-kernel at vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethernet
 
+DPAA2 ETHERNET SWITCH DRIVER
+M:	Razvan Stefanescu <razvan.stefanescu@nxp.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/staging/fsl-dpaa2/ethsw
+
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi at vger.kernel.org
-- 
1.9.1
