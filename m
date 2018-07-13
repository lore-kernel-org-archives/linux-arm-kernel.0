From: clabbe@baylibre.com (Corentin Labbe)
Date: Fri, 13 Jul 2018 11:48:42 +0000
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix typo descrive => describe
Message-ID: <1531482522-10824-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix a typo in the word Describe
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 2e6e2a96b4f2..f9a61f90cfbc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -37,7 +37,7 @@
  *		is done in the "stmmac files"
  */
 
-/* struct emac_variant - Descrive dwmac-sun8i hardware variant
+/* struct emac_variant - Describe dwmac-sun8i hardware variant
  * @default_syscon_value:	The default value of the EMAC register in syscon
  *				This value is used for disabling properly EMAC
  *				and used as a good starting value in case of the
-- 
2.16.4
