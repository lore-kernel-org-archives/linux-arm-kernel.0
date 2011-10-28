From: thutt@chromium.org (Taylor Hutt)
Date: Fri, 28 Oct 2011 09:27:06 -0700
Subject: [PATCH] arch: arm: tegra: Enable headphone detection gpio
Message-ID: <1319819226-19098-1-git-send-email-thutt@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yufeng Shen <miletus@chromium.org>

Enable the headphone detection gpio on tegra platform.

Signed-off-by: Yufeng Shen <miletus@chromium.org>
---
 arch/arm/mach-tegra/board-seaboard-pinmux.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index 9d0ba80..14e9d576 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -205,6 +205,7 @@ static struct tegra_gpio_table common_gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_NCT1008_THERM2_IRQ,.enable = true },
 	{ .gpio = TEGRA_GPIO_WLAN_POWER,	.enable = true },
 	{ .gpio = TEGRA_GPIO_AC_ONLINE,		.enable = true },
+	{ .gpio = TEGRA_GPIO_HP_DET,		.enable = true },
 	{ .gpio = TEGRA_GPIO_MXT_IRQ,		.enable = true },
 	{ .gpio = TEGRA_GPIO_HDMI_ENB,		.enable = true },
 	{ .gpio = TEGRA_GPIO_MPU3050_IRQ,	.enable = true },
-- 
1.7.3.1
