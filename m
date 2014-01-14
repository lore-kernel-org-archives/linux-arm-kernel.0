From: tinamdar@apm.com (Tanmay Inamdar)
Date: Tue, 14 Jan 2014 15:34:18 -0800
Subject: [RFC PATCH V2 4/4] MAINTAINERS: entry for APM X-Gene PCIe host driver
In-Reply-To: <1389742458-7693-1-git-send-email-tinamdar@apm.com>
References: <1389742458-7693-1-git-send-email-tinamdar@apm.com>
Message-ID: <1389742458-7693-5-git-send-email-tinamdar@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for AppliedMicro X-Gene PCIe host driver.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c20792..9e3ed53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6531,6 +6531,13 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*designware*
 
+PCI DRIVER FOR APPLIEDMICRO XGENE
+M:	Tanmay Inamdar <tinamdar@apm.com>
+L:	linux-pci at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	drivers/pci/host/pci-xgene.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia at lists.infradead.org
-- 
1.7.9.5
