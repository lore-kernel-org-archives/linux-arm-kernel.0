From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 09:35:59 +0800
Subject: [PATCH] clk: imx: vf610: fix whitespace in vf610-clock.h
Message-ID: <1460424959-14207-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is whitespace in VF610_CLK_OCOTP line.  Fix it.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 include/dt-bindings/clock/vf610-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index dc5e1790d8cb..45997750c8a0 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -194,7 +194,7 @@
 #define VF610_PLL7_BYPASS		181
 #define VF610_CLK_SNVS			182
 #define VF610_CLK_DAP			183
-#define VF610_CLK_OCOTP         184
+#define VF610_CLK_OCOTP			184
 #define VF610_CLK_DDRMC			185
 #define VF610_CLK_WKPU			186
 #define VF610_CLK_TCON0			187
-- 
1.9.1
