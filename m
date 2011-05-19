From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 19 May 2011 14:08:25 +0200
Subject: [PATCH 1/6] ARM: tegra: paz00: whitespace cleanup
In-Reply-To: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305806910-3903-2-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces long sequences of spaces by tabs and tabs by
spaces were appropriate.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |   12 ++++++------
 arch/arm/mach-tegra/board-paz00.h        |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index 2643d1b..d2faa50 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -141,12 +141,12 @@ static struct tegra_pingroup_config paz00_pinmux[] = {
 };
 
 static struct tegra_gpio_table gpio_table[] = {
-	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true	},
-	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true	},
-	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true	},
-	{ .gpio = TEGRA_GPIO_SD4_CD,	.enable = true	},
-	{ .gpio = TEGRA_GPIO_SD4_WP,	.enable = true	},
-	{ .gpio = TEGRA_GPIO_SD4_POWER,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true },
+	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
+	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
+	{ .gpio = TEGRA_GPIO_SD4_CD,	.enable = true },
+	{ .gpio = TEGRA_GPIO_SD4_WP,	.enable = true },
+	{ .gpio = TEGRA_GPIO_SD4_POWER,	.enable = true },
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index da193ca7..221ce9c 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -17,12 +17,12 @@
 #ifndef _MACH_TEGRA_BOARD_PAZ00_H
 #define _MACH_TEGRA_BOARD_PAZ00_H
 
-#define TEGRA_GPIO_SD1_CD               TEGRA_GPIO_PV5
-#define TEGRA_GPIO_SD1_WP               TEGRA_GPIO_PH1
-#define TEGRA_GPIO_SD1_POWER            TEGRA_GPIO_PT3
-#define TEGRA_GPIO_SD4_CD               TEGRA_GPIO_PH2
-#define TEGRA_GPIO_SD4_WP               TEGRA_GPIO_PH3
-#define TEGRA_GPIO_SD4_POWER            TEGRA_GPIO_PI6
+#define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PV5
+#define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PH1
+#define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PT3
+#define TEGRA_GPIO_SD4_CD		TEGRA_GPIO_PH2
+#define TEGRA_GPIO_SD4_WP		TEGRA_GPIO_PH3
+#define TEGRA_GPIO_SD4_POWER		TEGRA_GPIO_PI6
 
 void paz00_pinmux_init(void);
 
-- 
1.7.4.2
