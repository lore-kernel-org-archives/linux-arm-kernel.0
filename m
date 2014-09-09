From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue,  9 Sep 2014 15:26:59 +0530
Subject: [PATCH 5/5] MAINTAINERS: Add entry for APM Xgene QMTM UIO driver
In-Reply-To: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
References: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1410256619-3213-6-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry to maintainer list for APM Xgene QMTM UIO driver.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e7866a..138663f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -727,6 +727,13 @@ S:	Supported
 F:	drivers/net/ethernet/apm/xgene/
 F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 
+APPLIED MICRO (APM) X-GENE QMTM UIO DRIVER
+M:	Ankit Jindal <ankit.jindal@linaro.org>
+M:	Tushar Jagad <tushar.jagad@linaro.org>
+S:	Supported
+F:	drivers/uio/uio_xgene_qmtm.c
+F:	Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
+
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 L:	linux-media at vger.kernel.org
-- 
1.7.9.5
