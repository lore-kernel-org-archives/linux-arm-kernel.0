From: tinamdar@apm.com (Tanmay Inamdar)
Date: Wed, 19 Mar 2014 16:12:42 -0700
Subject: [PATCH v5 4/4] MAINTAINERS: entry for APM X-Gene PCIe host driver
In-Reply-To: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
Message-ID: <1395270762-6055-5-git-send-email-tinamdar@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for AppliedMicro X-Gene PCIe host driver.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3fdb0f..cc10644 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6638,6 +6638,13 @@ L:	linux-pci at vger.kernel.org
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
