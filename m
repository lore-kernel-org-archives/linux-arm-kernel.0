From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Aug 2012 15:40:09 +0900
Subject: [PATCH 1/2] ARM: mach-shmobile: armadillo800eva: Fix GPIO buttons
 descriptions
In-Reply-To: <1346049610-2266-1-git-send-email-horms@verge.net.au>
References: <1346049610-2266-1-git-send-email-horms@verge.net.au>
Message-ID: <1346049610-2266-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The GPIO buttons are named SW3, SW4, SW5 and SW6 on the board
silkscreen. Update the buttons descriptions accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index cf10f92..a002504 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -523,10 +523,10 @@ static struct platform_device hdmi_lcdc_device = {
 #define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
 static struct gpio_keys_button gpio_buttons[] = {
-	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW1"),
-	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW2"),
-	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW3"),
-	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW4"),
+	GPIO_KEY(KEY_POWER,	GPIO_PORT99,	"SW3"),
+	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW4"),
+	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW5"),
+	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW6"),
 };
 
 static struct gpio_keys_platform_data gpio_key_info = {
-- 
1.7.10.2.484.gcd07cc5
