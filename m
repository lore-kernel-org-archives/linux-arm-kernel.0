From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 13:48:27 +0100
Subject: [PATCH 2/2] reset: mediatek: Add MT2701 ethsys reset controller
 include file
In-Reply-To: <1485175707-58528-1-git-send-email-john@phrozen.org>
References: <1485175707-58528-1-git-send-email-john@phrozen.org>
Message-ID: <1485175707-58528-3-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing reset bits of the ethsys core to the mt2701-reset include
file, so that we can reference them from within a devicetree file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/dt-bindings/reset/mt2701-resets.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/reset/mt2701-resets.h b/include/dt-bindings/reset/mt2701-resets.h
index aaf0305..21deb54 100644
--- a/include/dt-bindings/reset/mt2701-resets.h
+++ b/include/dt-bindings/reset/mt2701-resets.h
@@ -80,4 +80,11 @@
 #define MT2701_HIFSYS_PCIE1_RST			25
 #define MT2701_HIFSYS_PCIE2_RST			26
 
+/* ETHSYS resets */
+#define MT2701_ETHSYS_SYS_RST			0
+#define MT2701_ETHSYS_MCM_RST			2
+#define MT2701_ETHSYS_FE_RST			6
+#define MT2701_ETHSYS_GMAC_RST			23
+#define MT2701_ETHSYS_PPE_RST			31
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT2701 */
-- 
1.7.10.4
