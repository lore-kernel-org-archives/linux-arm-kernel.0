From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Tue, 21 Jul 2015 14:48:43 +0800
Subject: [PATCH v4 5/5] MAINTAINERS: Add pcie-hisi maintainer
In-Reply-To: <1437461323-3531-1-git-send-email-wangzhou1@hisilicon.com>
References: <1437461323-3531-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1437461323-3531-6-git-send-email-wangzhou1@hisilicon.com>
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
