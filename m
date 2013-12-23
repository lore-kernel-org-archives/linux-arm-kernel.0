From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:13 +0900
Subject: [PATCH 17/26] ARM: shmobile: Hook up SW30-SW36 on Koelsch
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <159a282dc3a1bcc9a0cc3a41304c41eef229add1.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for Koelsch SW30-SW36 using GPIO keys.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index f0fe5d4..412e153 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -64,6 +64,13 @@ static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_3,		RCAR_GP_PIN(5, 2),	"SW2-pin3"),
 	GPIO_KEY(KEY_2,		RCAR_GP_PIN(5, 1),	"SW2-pin2"),
 	GPIO_KEY(KEY_1,		RCAR_GP_PIN(5, 0),	"SW2-pin1"),
+	GPIO_KEY(KEY_G,		RCAR_GP_PIN(7, 6),	"SW36"),
+	GPIO_KEY(KEY_F,		RCAR_GP_PIN(7, 5),	"SW35"),
+	GPIO_KEY(KEY_E,		RCAR_GP_PIN(7, 4),	"SW34"),
+	GPIO_KEY(KEY_D,		RCAR_GP_PIN(7, 3),	"SW33"),
+	GPIO_KEY(KEY_C,		RCAR_GP_PIN(7, 2),	"SW32"),
+	GPIO_KEY(KEY_B,		RCAR_GP_PIN(7, 1),	"SW31"),
+	GPIO_KEY(KEY_A,		RCAR_GP_PIN(7, 0),	"SW30"),
 };
 
 static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
-- 
1.8.4
