From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:23 +0100
Subject: [RESEND 01/10] ARM: multi_v7_defconfig: Enable ST's PWM driver
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1b..21c9e12 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -626,6 +626,7 @@ CONFIG_PWM_SAMSUNG=m
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_PHY_HIX5HD2_SATA=y
+CONFIG_PWM_STI=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY28LP=y
-- 
1.9.1
