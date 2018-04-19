From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 19 Apr 2018 11:20:32 -0400
Subject: [PATCH] MAINTAINERS: add maintainer for Qualcomm HIDMA drivers
Message-ID: <1524151261-13461-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/dma/qcom directory is being shared by multiple QCOM dmaengine
drivers. Separate ownership by filenames.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff14894..111dd8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11669,6 +11669,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.g
 S:	Supported
 F:	arch/hexagon/
 
+QUALCOMM HIDMA DRIVER
+M:	Sinan Kaya <okaya@codeaurora.org>
+L:	linux-arm-kernel at lists.infradead.org
+L:	linux-arm-msm at vger.kernel.org
+L:	dmaengine at vger.kernel.org
+S:	Supported
+F:	drivers/dma/qcom/hidma*
+
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
 L:	iommu at lists.linux-foundation.org
-- 
2.7.4
