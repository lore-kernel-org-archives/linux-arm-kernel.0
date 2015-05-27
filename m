From: dhdang@apm.com (Duc Dang)
Date: Wed, 27 May 2015 11:27:39 -0700
Subject: [PATCH v9 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene
 v1 PCIe MSI driver
In-Reply-To: <cover.1432747280.git.dhdang@apm.com>
References: <cover.1432747280.git.dhdang@apm.com>
Message-ID: <3cc41de5c67f27d490459d39806b0c0fcc3e1cd1.1432747280.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds information of maintainers for APM X-Gene v1 PCIe
MSI/MSIX termination driver

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 781e099..59aa7b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7564,6 +7564,14 @@ L:	linux-pci at vger.kernel.org
 S:	Orphan
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
