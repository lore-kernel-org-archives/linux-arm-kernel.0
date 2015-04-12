From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Sun, 12 Apr 2015 14:25:43 +0300
Subject: [PATCH v2 1/2] pinctrl: mvebu: Fix mapping of pin 63 (gpo -> gpio)
In-Reply-To: <1428837944-28150-1-git-send-email-andrew@ncrmnt.org>
References: <1428837944-28150-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <1428837944-28150-2-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index c4f51d0..78c332d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -364,7 +364,7 @@ static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	   MPP_FUNCTION(0x5, "audio", "mclk"),
 	   MPP_FUNCTION(0x6, "uart0", "cts")),
 	MPP_MODE(63,
-	   MPP_FUNCTION(0x0, "gpo", NULL),
+	   MPP_FUNCTION(0x0, "gpio", NULL),
 	   MPP_FUNCTION(0x1, "spi0", "sck"),
 	   MPP_FUNCTION(0x2, "tclk", NULL)),
 	MPP_MODE(64,
-- 
1.7.10.4
