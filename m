From: dhdang@apm.com (Duc Dang)
Date: Tue,  6 Jan 2015 08:15:44 -0800
Subject: [PATCH 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene v1
 PCIe MSI driver
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
Message-ID: <9fd7f3ec58431a0fcba3600a0325920c86bc69fa.1420499393.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds information of maintainers for APM X-Gene v1 PCIe
MSI/MSIX termination driver

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..283f09a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7303,6 +7303,14 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
+PCI MSI DRIVER FOR APPLIEDMICRO XGENE
+M:	Duc Dang <dhdang@apm.com>
+L:	linux-pci at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
+F:	drivers/pci/host/pci-xgene-msi.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia at lists.infradead.org
-- 
1.9.1
