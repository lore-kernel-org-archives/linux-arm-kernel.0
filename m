From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  6 Sep 2014 01:06:13 +0200
Subject: [PATCH 10/11] ARM: rockchip: enable cpufreq-related options
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <1409958374-30937-11-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_HAS_CPUFREQ and ARCH_HAS_OPP.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index d168669..007e9dd 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -2,6 +2,8 @@ config ARCH_ROCKCHIP
 	bool "Rockchip RK2928 and RK3xxx SOCs" if ARCH_MULTI_V7
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
-- 
2.0.1
