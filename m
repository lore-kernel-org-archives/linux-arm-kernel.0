From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 20 Mar 2017 14:47:27 +0800
Subject: [PATCH v6 4/4] mfd: mt6397: Align the placement at which the mfd_cell
 of LED is defined
In-Reply-To: <1489992447-13007-1-git-send-email-sean.wang@mediatek.com>
References: <1489992447-13007-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1489992447-13007-5-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Align the placement as which the mfd_cell of LED is defined as the other
members done on the structure.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6397-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 8e601c8..04a601f 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -47,8 +47,7 @@
 	{
 		.name = "mt6323-regulator",
 		.of_compatible = "mediatek,mt6323-regulator"
-	},
-	{
+	}, {
 		.name = "mt6323-led",
 		.of_compatible = "mediatek,mt6323-led"
 	},
-- 
1.9.1
