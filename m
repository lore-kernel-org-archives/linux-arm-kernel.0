From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 1 Jul 2015 17:43:37 +0800
Subject: [PATCH v3 5/5] MAINTAINERS: Add pcie-hisi maintainer
In-Reply-To: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1435743817-19083-6-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8afd29..3f083d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7594,6 +7594,13 @@ L:	linux-pci at vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
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
