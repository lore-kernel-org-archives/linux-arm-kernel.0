From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 20 Nov 2013 13:00:10 +0900
Subject: [PATCH] ARM: shmobile: Hook up SW30-SW36 on Koelsch
Message-ID: <20131120040010.30077.40904.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for Koelsch SW30-SW36 using GPIO keys.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0016/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-11-20 12:49:32.000000000 +0900
@@ -64,6 +64,13 @@ static struct gpio_keys_button gpio_butt
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
