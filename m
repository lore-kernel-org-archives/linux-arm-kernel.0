From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon,  2 Jun 2014 12:39:11 -0700
Subject: [PATCH v5 1/4] MAINTAINERS: Add entry for APM X-Gene SoC ethernet
 driver
In-Reply-To: <1401737954-26152-1-git-send-email-isubramanian@apm.com>
References: <1401737954-26152-1-git-send-email-isubramanian@apm.com>
Message-ID: <1401737954-26152-2-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for APM X-Gene SoC
ethernet driver.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Ravi Patel <rapatel@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd33abf..42ca1b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -686,6 +686,14 @@ S:	Maintained
 F:	drivers/net/appletalk/
 F:	net/appletalk/
 
+APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
+M:	Iyappan Subramanian <isubramanian@apm.com>
+M:	Keyur Chudgar <kchudgar@apm.com>
+M:	Ravi Patel <rapatel@apm.com>
+S:	Supported
+F:	drivers/net/ethernet/apm/xgene/
+F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 L:	linux-media at vger.kernel.org
-- 
1.7.9.5
