From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 12 Nov 2014 13:03:16 -0800
Subject: [PATCH 3.19 1/2] ARM: multi_v7_defconfig: remove one level of menu
 from Kconfig
In-Reply-To: <1415826197-6748-1-git-send-email-f.fainelli@gmail.com>
References: <1415826197-6748-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1415826197-6748-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Branden <sbranden@broadcom.com>

remove menu "Broadcom Mobile SoC Selection"
This requires:
- selecting ARCH_BCM_MOBILE based on SoC selections
- fixup multi_v7_defconfig to work with new menu levels of mach-bcm.

Signed-off-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 491b7d5523bf..e8f79fdd4cc3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -17,7 +17,8 @@ CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_MACH_DOVE=y
 CONFIG_ARCH_BCM=y
-CONFIG_ARCH_BCM_MOBILE=y
+CONFIG_ARCH_BCM_21664=y
+CONFIG_ARCH_BCM_281XX=y
 CONFIG_ARCH_BCM_5301X=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
-- 
1.9.1
