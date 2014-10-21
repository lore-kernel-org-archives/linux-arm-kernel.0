From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue, 21 Oct 2014 11:26:50 +0530
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for APM X-Gene QMTM UIO driver
In-Reply-To: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
References: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1413871011-4101-7-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry to maintainer list for APM X-Gene QMTM UIO driver.

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
