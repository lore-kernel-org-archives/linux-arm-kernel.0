From: marvin24@gmx.de (Marc Dietrich)
Date: Mon,  7 Mar 2011 21:01:32 +0100
Subject: [PATCH v2 2/2] Add PAZ00 to tegra_defconfig
In-Reply-To: <cover.1299526691.git.marvin24@gmx.de>
References: <cover.1299526691.git.marvin24@gmx.de>
Message-ID: <cca9e47acefe58552c4d5754cf230481f467cb07.1299526691.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject says it all, this one adds PAZ00 to tegra_defconfig.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/configs/tegra_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 7a9267e..3fcf6f5 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -21,6 +21,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_TEGRA=y
 CONFIG_MACH_HARMONY=y
+CONFIG_MACH_PAZ00=y
 CONFIG_TEGRA_DEBUG_UARTD=y
 CONFIG_ARM_ERRATA_742230=y
 CONFIG_NO_HZ=y
-- 
1.7.1
