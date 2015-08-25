From: lftan@altera.com (Ley Foon Tan)
Date: Tue, 25 Aug 2015 17:35:48 +0800
Subject: [PATCH v5 5/5] MAINTAINERS: Add Altera PCIe and MSI drivers maintainer
In-Reply-To: <1440495348-2666-1-git-send-email-lftan@altera.com>
References: <1440495348-2666-1-git-send-email-lftan@altera.com>
Message-ID: <1440495348-2666-6-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 569568f..c87e451 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7779,6 +7779,14 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI DRIVER FOR ALTERA PCIE IP
+M:	Ley Foon Tan <lftan@altera.com>
+L:	rfi at lists.rocketboards.org (moderated for non-subscribers)
+L:	linux-pci at vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
+F:	drivers/pci/host/pcie-altera.c
+
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
 L:	linux-pci at vger.kernel.org
@@ -7880,6 +7888,14 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
+PCI MSI DRIVER FOR ALTERA MSI IP
+M:	Ley Foon Tan <lftan@altera.com>
+L:	rfi at lists.rocketboards.org (moderated for non-subscribers)
+L:	linux-pci at vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
+F:	drivers/pci/host/pcie-altera-msi.c
+
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
 M:	Duc Dang <dhdang@apm.com>
 L:	linux-pci at vger.kernel.org
-- 
1.8.2.1
