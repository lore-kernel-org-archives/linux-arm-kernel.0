From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 23 Jan 2017 15:15:32 +0800
Subject: [PATCH] pinctrl: berlin-bg4ct: fix the value for "sd1a" of pin
 SCRD0_CRD_PRES
Message-ID: <20170123071532.2896-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should be a typo.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pinctrl/berlin/berlin-bg4ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berlin/berlin-bg4ct.c
index 09172043d589..c617ec49e9ed 100644
--- a/drivers/pinctrl/berlin/berlin-bg4ct.c
+++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
@@ -217,7 +217,7 @@ static const struct berlin_desc_group berlin4ct_soc_pinctrl_groups[] = {
 	BERLIN_PINCTRL_GROUP("SCRD0_CRD_PRES", 0xc, 0x3, 0x15,
 			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO20 */
 			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0"), /* crd pres */
-			BERLIN_PINCTRL_FUNCTION(0x1, "sd1a")), /* DAT3 */
+			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a")), /* DAT3 */
 	BERLIN_PINCTRL_GROUP("SPI1_SS0n", 0xc, 0x3, 0x18,
 			BERLIN_PINCTRL_FUNCTION(0x0, "spi1"), /* SS0n */
 			BERLIN_PINCTRL_FUNCTION(0x1, "gpio"), /* GPIO37 */
-- 
2.11.0
