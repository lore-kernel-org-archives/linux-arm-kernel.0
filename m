From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 18:15:46 +0200
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: add the Atmel Audio microphone
 interface PDMIC
In-Reply-To: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
References: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
Message-ID: <8fb57d1a6f495a3cf5f0a5f9cca38740632a8504.1461687187.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Atmel Pulse Density Modulation Interface Controller (PDMIC) driver
as a module. It's used by sama5d2 SoC for instance.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 901eaf55c5a7..6a62ebbcae28 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -569,6 +569,7 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
+CONFIG_SND_ATMEL_SOC_PDMIC=m
 CONFIG_SND_SOC_FSL_SAI=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
-- 
2.1.3
