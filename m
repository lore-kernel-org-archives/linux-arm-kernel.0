From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Sep 2017 16:15:02 -0700
Subject: [PATCH v2 10/10] ARM: multi_v7_defconfig: Enable CONFIG_ARCH_BCM_HR2
In-Reply-To: <20170928231502.27069-1-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
Message-ID: <20170928231502.27069-11-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn on Broadcom Hurrican 2 SoC support by default to get access to its
drivers.

Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0cacdbf84a71..810cecf66eeb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -31,6 +31,7 @@ CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_CYGNUS=y
+CONFIG_ARCH_BCM_HR2=y
 CONFIG_ARCH_BCM_NSP=y
 CONFIG_ARCH_BCM_21664=y
 CONFIG_ARCH_BCM_281XX=y
-- 
2.14.1
