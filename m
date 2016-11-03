From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Thu,  3 Nov 2016 11:16:00 +0100
Subject: [PATCH v7 2/3] ARM: sunxi_defconfig: Add CONFIG_THERMAL_OF
In-Reply-To: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
References: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Message-ID: <20161103101601.24529-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables CONFIG_THERMAL_OF by default for sunxi_defconfig.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v7

 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 714da33..8aaeae3 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -83,6 +83,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
+CONFIG_THERMAL_OF=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
-- 
2.9.3
