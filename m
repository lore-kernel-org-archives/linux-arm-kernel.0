From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 13:51:15 +0900
Subject: [PATCH] sh-pfc: r8a7779: tidyup intc_irq3_b typo
In-Reply-To: <1365569475-28721-1-git-send-email-horms+renesas@verge.net.au>
References: <1365569475-28721-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365569475-28721-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 62dcdcd..791a671 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2552,7 +2552,7 @@ static const char * const intc_groups[] = {
 	"intc_irq2",
 	"intc_irq2_b",
 	"intc_irq3",
-	"intc_irq4_b",
+	"intc_irq3_b",
 };
 
 static const char * const lbsc_groups[] = {
-- 
1.7.10.4
