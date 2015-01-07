From: mchitale@apm.com (Mayuresh Chitale)
Date: Wed,  7 Jan 2015 10:58:54 +0530
Subject: [PATCH 1/4] MAINTAINERS: Add entry for X-Gene PCIE DMA driver
In-Reply-To: <1420608537-12296-1-git-send-email-mchitale@apm.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
Message-ID: <1420608537-12296-2-git-send-email-mchitale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mayuresh Chitale <mchitale@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..9d24a02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7228,6 +7228,14 @@ L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
 F:	drivers/pci/host/*layerscape*
 
+PCI DMA DRIVER FOR APPLIEDMICRO XGENE
+M:	Mayuresh Chitale <mchitale@apm.com>
+L:	dmaengine at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/xgene-pcie-dma.txt
+F:	drivers/dma/xgene-pcie-dma.c
+
+
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <r65037@freescale.com>
 M:	Lucas Stach <l.stach@pengutronix.de>
-- 
2.2.1.212.gc5b9256
