From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 25 Sep 2015 10:14:57 +0800
Subject: [PATCH v2 3/4] arm64: Enable the timer on Rockchip architecture
In-Reply-To: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1443147298-12603-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the RK3368 SoC, support the APB timers for rockchip platform.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None
Changes in v1: None

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a1..0dae08d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -57,6 +57,7 @@ config ARCH_ROCKCHIP
 	select ARCH_REQUIRE_GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
+	select ROCKCHIP_TIMER
 	help
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
-- 
1.9.1
