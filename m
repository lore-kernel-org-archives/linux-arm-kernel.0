From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 11:37:47 +0200
Subject: [PATCH v3 1/3] pinctrl: berlin: fix spi1 SS0n function name
In-Reply-To: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1433237869-3762-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename function ss0 to spi1 to be consistent with the other Berlin
function names.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/berlin-bg2cd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 9e11f191d643..5cfadbc14a79 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -68,7 +68,7 @@ static const struct berlin_desc_group berlin2cd_soc_pinctrl_groups[] = {
 		BERLIN_PINCTRL_FUNCTION(0x1, "twsi1"),
 		BERLIN_PINCTRL_FUNCTION(0x2, "gpio")),
 	BERLIN_PINCTRL_GROUP("G8", 0x00, 0x3, 0x10,
-		BERLIN_PINCTRL_FUNCTION(0x0, "ss0"),
+		BERLIN_PINCTRL_FUNCTION(0x0, "spi1"),
 		BERLIN_PINCTRL_FUNCTION(0x1, "gpio")),
 	BERLIN_PINCTRL_GROUP("G9", 0x00, 0x3, 0x13,
 		BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
-- 
2.4.2
