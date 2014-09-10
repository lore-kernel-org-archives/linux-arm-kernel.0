From: tinamdar@apm.com (Tanmay Inamdar)
Date: Wed, 10 Sep 2014 16:20:20 -0700
Subject: [PATCH v7 4/4] MAINTAINERS: entry for APM X-Gene PCIe host driver
In-Reply-To: <1410391220-4866-1-git-send-email-tinamdar@apm.com>
References: <1410391220-4866-1-git-send-email-tinamdar@apm.com>
Message-ID: <1410391220-4866-5-git-send-email-tinamdar@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for AppliedMicro X-Gene PCIe host driver.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e7866a..cd9bb3da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6941,6 +6941,14 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
+PCI DRIVER FOR APPLIEDMICRO XGENE
+M:	Tanmay Inamdar <tinamdar@apm.com>
+L:	linux-pci at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
+F:	drivers/pci/host/pci-xgene.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia at lists.infradead.org
-- 
1.9.1
