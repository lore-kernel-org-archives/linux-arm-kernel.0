From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 17 Feb 2017 15:20:41 +0530
Subject: [PATCH v2 21/22] MAINTAINERS: add PCI EP maintainer
In-Reply-To: <1487325042-28227-1-git-send-email-kishon@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
Message-ID: <1487325042-28227-22-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer for the newly introduced PCI EP framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8672f18..62b86af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9407,6 +9407,15 @@ F:	include/linux/pci*
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
