From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 12:07:30 -0700
Subject: [PATCH 5/7] ARM: multi_v7_defconfig: Enable Broadcom STB PWM
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1463771252-12805-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 13e5af6334ac..b59081bda51b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -816,6 +816,7 @@ CONFIG_PWM_VT8500=y
 CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PWM_STI=y
 CONFIG_PWM_BCM2835=y
+CONFIG_PWM_BRCMSTB=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_BERLIN_USB=y
-- 
2.7.4
