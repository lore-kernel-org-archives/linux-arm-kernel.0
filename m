From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri,  3 Mar 2017 17:09:32 -0800
Subject: [PATCH v3 net-next 6/6] MAINTAINERS: Add entry for APM X-Gene SoC
 Ethernet (v2) driver
In-Reply-To: <1488589773-28055-1-git-send-email-isubramanian@apm.com>
References: <1488589773-28055-1-git-send-email-isubramanian@apm.com>
Message-ID: <1488589773-28055-7-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MAINTAINERS entry for the ethernet driver for
the on-chip ethernet interface which uses a linked list of DMA
descriptor architecture (v2) for APM X-Gene SoCs.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 846f97a..ccb9814 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -902,6 +902,12 @@ F:	drivers/net/phy/mdio-xgene.c
 F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 
+APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
+M:	Iyappan Subramanian <isubramanian@apm.com>
+M:	Keyur Chudgar <kchudgar@apm.com>
+S:	Supported
+F:	drivers/net/ethernet/apm/xgene-v2/
+
 APPLIED MICRO (APM) X-GENE SOC PMU
 M:	Tai Nguyen <ttnguyen@apm.com>
 S:	Supported
-- 
1.9.1
