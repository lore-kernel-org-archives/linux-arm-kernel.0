From: dhdang@apm.com (Duc Dang)
Date: Fri, 29 May 2015 11:24:32 -0700
Subject: [PATCH v10 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene
 v1 PCIe MSI driver
In-Reply-To: <cover.1432922451.git.dhdang@apm.com>
References: <cover.1432922451.git.dhdang@apm.com>
Message-ID: <e736a576b418c91d8db2d9eda63bb3660c17dfb1.1432922451.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds information of maintainers for APM X-Gene v1 PCIe
MSI/MSIX termination driver.

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
