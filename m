From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Apr 2017 14:22:42 +0530
Subject: [PATCH v6 22/23] MAINTAINERS: Add PCI Endpoint maintainer
In-Reply-To: <20170405085243.18123-1-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
Message-ID: <20170405085243.18123-23-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer for the newly introduced PCI Endpoint framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c265a5fe4848..15ed84389092 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9581,6 +9581,15 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI ENDPOINT SUBSYSTEM
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-pci at vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
+S:	Supported
+F:	drivers/pci/endpoint/
+F:	drivers/misc/pci_endpoint_test.c
+F:	tools/pci/
+
 PCI DRIVER FOR ALTERA PCIE IP
 M:	Ley Foon Tan <lftan@altera.com>
 L:	rfi at lists.rocketboards.org (moderated for non-subscribers)
-- 
2.11.0
