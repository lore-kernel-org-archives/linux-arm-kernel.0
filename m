From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 6 Nov 2018 14:42:04 +0800
Subject: [PATCH v1 09/11] dt-bindings: soc: fix typo of MT8173 power
 dt-bindings
In-Reply-To: <20181106064206.17535-1-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
Message-ID: <20181106064206.17535-11-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix incorrect IC name that will affect the MT8183 power dt-bindings

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/power/mt8173-power.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/power/mt8173-power.h b/include/dt-bindings/power/mt8173-power.h
index 15d531aa6e78..ef4a7f944848 100644
--- a/include/dt-bindings/power/mt8173-power.h
+++ b/include/dt-bindings/power/mt8173-power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
-#define _DT_BINDINGS_POWER_MT8183_POWER_H
+#ifndef _DT_BINDINGS_POWER_MT8173_POWER_H
+#define _DT_BINDINGS_POWER_MT8173_POWER_H
 
 #define MT8173_POWER_DOMAIN_VDEC	0
 #define MT8173_POWER_DOMAIN_VENC	1
@@ -13,4 +13,4 @@
 #define MT8173_POWER_DOMAIN_MFG_2D	8
 #define MT8173_POWER_DOMAIN_MFG		9
 
-#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
+#endif /* _DT_BINDINGS_POWER_MT8173_POWER_H */
-- 
2.18.0
