From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Nov 2016 11:10:23 +0100
Subject: [PATCH v7 5/8] clk: sunxi-ng: define the PLL DE clock
In-Reply-To: <cover.1480414715.git.moinejf@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
Message-ID: <1c15124226a9aeb5bdcad6bc0e5b54d91991c7f5.1480414715.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 include/dt-bindings/clock/sun8i-h3-ccu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index efb7ba2..7af57b7 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -44,6 +44,7 @@
 #define _DT_BINDINGS_CLK_SUN8I_H3_H_
 
 #define CLK_CPUX		14
+#define CLK_PLL_DE		13
 
 #define CLK_BUS_CE		20
 #define CLK_BUS_DMA		21
-- 
2.10.2
