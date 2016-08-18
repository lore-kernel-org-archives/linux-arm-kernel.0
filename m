From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 18 Aug 2016 14:38:46 +0800
Subject: [PATCH v1 3/5] MAINTAINERS: add maintainer entry for QorIQ QDMA driver
In-Reply-To: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1471502328-28305-4-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Add a maintainer entry for QorIQ QDMA driver and add myself
as a maintainer.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a309db..278d2f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4934,6 +4934,13 @@ L:	linuxppc-dev at lists.ozlabs.org
 S:	Maintained
 F:	drivers/dma/fsldma.*
 
+QorIQ QDMA DRIVER
+M:	Yuan Yao <yao.yuan@nxp.com>
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/qoriq-qdma.txt
+F:	drivers/dma/qoriq-qdma.*
+
 FREESCALE GPMI NAND DRIVER
 M:	Han Xu <han.xu@nxp.com>
 L:	linux-mtd at lists.infradead.org
-- 
2.1.0.27.g96db324
