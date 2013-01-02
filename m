From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 2 Jan 2013 15:57:25 +0530
Subject: [PATCH v3 1/7] ARM: OMAP2+: omap2plus_defconfig: Add tps65910 support
In-Reply-To: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Message-ID: <1357122451-7577-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335X-EVM and AM335X-EVMSK devices have tps65910 PMIC regulator, one
has to manually enable this support to use regulators. So this patch
enables tps65910 mfd and regulator drivers in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 82ce8d7..ee6e060 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -135,10 +135,12 @@ CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
+CONFIG_REGULATOR_TPS65910=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5
