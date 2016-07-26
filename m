From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon, 25 Jul 2016 17:12:47 -0700
Subject: [PATCH net-next v7 12/12] MAINTAINERS: xgene: Add driver and
 documentation path
In-Reply-To: <1469491967-28627-1-git-send-email-isubramanian@apm.com>
References: <1469491967-28627-1-git-send-email-isubramanian@apm.com>
Message-ID: <1469491967-28627-13-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added path to the MDIO driver and Documentation file.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc3481d..a9bdba0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -839,7 +839,9 @@ M:	Iyappan Subramanian <isubramanian@apm.com>
 M:	Keyur Chudgar <kchudgar@apm.com>
 S:	Supported
 F:	drivers/net/ethernet/apm/xgene/
+F:	drivers/net/phy/mdio-xgene.c
 F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
-- 
1.9.1
