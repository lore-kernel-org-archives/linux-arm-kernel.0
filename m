From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 Nov 2016 16:48:31 +0200
Subject: [PATCH 6/6] ARM: s5pv210_defconfig: Remove old MACHs
In-Reply-To: <1479566911-5580-1-git-send-email-krzk@kernel.org>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
Message-ID: <1479566911-5580-7-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove non-existing MACH symbols from S5PV210 defconfig.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/s5pv210_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index fa989902236d..c51f0f02012b 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -9,10 +9,6 @@ CONFIG_ARCH_S5PV210=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_S3C_DEV_FB=y
 CONFIG_S5PV210_SETUP_FB_24BPP=y
-CONFIG_MACH_AQUILA=y
-CONFIG_MACH_GONI=y
-CONFIG_MACH_SMDKC110=y
-CONFIG_MACH_SMDKV210=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_VMSPLIT_2G=y
-- 
2.7.4
