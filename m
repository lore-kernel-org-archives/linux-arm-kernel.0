From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 9 Mar 2017 13:27:33 +0530
Subject: [PATCH v3 22/23] MAINTAINERS: add PCI EP maintainer
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
Message-ID: <1489046254-19919-23-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer for the newly introduced PCI EP framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c265a5f..3c1b947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9581,6 +9581,15 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI EP SUBSYSTEM
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
1.7.9.5
