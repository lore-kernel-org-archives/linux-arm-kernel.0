From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  2 Sep 2014 09:50:14 +0200
Subject: [PATCH 1/5] clk: at91: fix PLL_MAX_COUNT macro definition
In-Reply-To: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409644218-13677-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Ga?l PORTAY <gael.portay@gmail.com>
---
 drivers/clk/at91/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index cf6ed02..7b453b9 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -31,7 +31,7 @@
 				 (layout)->mul_mask)
 #define PLL_ICPR_SHIFT(id)	((id) * 16)
 #define PLL_ICPR_MASK(id)	(0xffff << PLL_ICPR_SHIFT(id))
-#define PLL_MAX_COUNT		0x3ff
+#define PLL_MAX_COUNT		0x3f
 #define PLL_COUNT_SHIFT		8
 #define PLL_OUT_SHIFT		14
 #define PLL_MAX_ID		1
-- 
1.9.1
