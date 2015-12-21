From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Dec 2015 22:21:55 +0100
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: enable rockchip crypto module
In-Reply-To: <2111669.2aeXLpXsWE@diego>
References: <2111669.2aeXLpXsWE@diego>
Message-ID: <2478699.f7vgsBG0hI@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the newly added hardware crypto module
found for example on the rk3288.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index be57898..ff7eb19 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -733,6 +733,7 @@ CONFIG_CRYPTO_DEV_TEGRA_AES=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_CRYPTO_DEV_SUN4I_SS=m
+CONFIG_CRYPTO_DEV_ROCKCHIP=m
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
-- 
2.6.4
