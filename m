From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 18:20:05 +0200
Subject: [PATCH 4/4] arm: sunxi: Add additional power supplies
In-Reply-To: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
Message-ID: <20170721162005.18892-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bunch of new power supplies have been added recently to handle the
batteries and the AC-IN plugs. Add them to our defconfig.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 456988dd7b0e..0d29834b9688 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -77,6 +77,8 @@ CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_CHARGER_AXP20X=y
+CONFIG_BATTERY_AXP20X=y
 CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
-- 
2.13.3
