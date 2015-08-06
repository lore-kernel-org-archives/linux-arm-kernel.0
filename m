From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Thu, 6 Aug 2015 16:09:19 +0800
Subject: [PATCH v6 6/6] MAINTAINERS: Add pcie-hisi maintainer
In-Reply-To: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1438848559-232109-7-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..7cd8e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7854,6 +7854,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/host/pci-xgene-msi.c
 
+PCIE DRIVER FOR HISILICON
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-pci at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+F:	drivers/pci/host/pcie-hisi.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia at lists.infradead.org
-- 
1.9.1
