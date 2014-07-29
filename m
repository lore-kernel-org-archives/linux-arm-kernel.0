From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 29 Jul 2014 21:12:06 +0200
Subject: [PATCH 2/4] ARM: rockchip: enable the AMBA bus
In-Reply-To: <1406661128-7614-1-git-send-email-heiko@sntech.de>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
Message-ID: <1406661128-7614-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to access the pl330 dma controllers on Rockchip SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index d168669..ac5803c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -4,6 +4,7 @@ config ARCH_ROCKCHIP
 	select PINCTRL_ROCKCHIP
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_ARCH_TIMER
-- 
2.0.1
