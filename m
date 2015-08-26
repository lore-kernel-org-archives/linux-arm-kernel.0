From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 26 Aug 2015 18:35:29 -0400
Subject: [PATCH v2 4/5] ARM: multi_v7_defconfig: Add NSP to defconfig
In-Reply-To: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1440628530-6137-5-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Broadcom Northstar Plus SoC to the multi_v7_defconfig

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fd8df6..3fd46f7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -25,6 +25,7 @@ CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_CYGNUS=y
+CONFIG_ARCH_BCM_NSP=y
 CONFIG_ARCH_BCM_21664=y
 CONFIG_ARCH_BCM_281XX=y
 CONFIG_ARCH_BCM_5301X=y
-- 
1.9.1
