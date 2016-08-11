From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Thu, 11 Aug 2016 16:07:08 +0800
Subject: [PATCH] dt-binding: correct the larb port offset defines for mt2701
Message-ID: <1470902828-32496-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

larb2 have 23 ports, the LARB3_PORT_OFFSET should be LARB2_PORT_OFFSET
plus larb2's port number, it should be 44 instead of 43.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 include/dt-bindings/memory/mt2701-larb-port.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/memory/mt2701-larb-port.h b/include/dt-bindings/memory/mt2701-larb-port.h
index 78f6678..6764d74 100644
--- a/include/dt-bindings/memory/mt2701-larb-port.h
+++ b/include/dt-bindings/memory/mt2701-larb-port.h
@@ -26,7 +26,7 @@
 #define LARB0_PORT_OFFSET		0
 #define LARB1_PORT_OFFSET		11
 #define LARB2_PORT_OFFSET		21
-#define LARB3_PORT_OFFSET		43
+#define LARB3_PORT_OFFSET		44
 
 #define MT2701_M4U_ID_LARB0(port)	((port) + LARB0_PORT_OFFSET)
 #define MT2701_M4U_ID_LARB1(port)	((port) + LARB1_PORT_OFFSET)
-- 
1.8.1.1.dirty
