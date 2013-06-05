From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:47 +0900
Subject: [PATCH 116/130] sh-pfc: r8a7778: fixup IRQ1A settings
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-117-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

IP2[31] func2 is IRQ1A, not IRQ3A

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index bc20083..6b2c6b5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2080,7 +2080,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 			     1, 1, 1, 1, 3, 2, 3, 3, 3, 3) {
 		/* IP2_31 [1] */
-		FN_MLB_CLK,	FN_IRQ3_A,
+		FN_MLB_CLK,	FN_IRQ1_A,
 		/* IP2_30 [1] */
 		FN_RD_WR_B,	FN_IRQ0,
 		/* IP2_29 [1] */
-- 
1.8.2.1
