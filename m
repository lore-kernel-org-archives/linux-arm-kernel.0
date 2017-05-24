From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 15:54:10 +0200
Subject: [PATCH 2/7] arm64: defconfig: enable Rockchip saradc
In-Reply-To: <20170524135415.5590-1-heiko@sntech.de>
References: <20170524135415.5590-1-heiko@sntech.de>
Message-ID: <20170524135415.5590-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the sucessfive approximation adc that gets often used for example
for additional buttons on Rockchip boards.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a12ccb40ce0a..f4492605c0a9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -474,6 +474,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
+CONFIG_ROCKCHIP_SARADC=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_MESON=m
-- 
2.11.0
