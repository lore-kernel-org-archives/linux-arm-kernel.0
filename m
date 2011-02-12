From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Feb 2011 16:59:46 +0530
Subject: [PATCH 4/5] omap2plus: omap4: Set NR_CPU to 2 instead of default 4
In-Reply-To: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1297510187-31547-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap2plus_defconfig picks default NR_CPU value as 4 which isn't
correct for OMAP4430. Available CPUs are ony 2, so fix the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ae890ca..019fb7c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -58,6 +58,7 @@ CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
+CONFIG_NR_CPUS=2
 # CONFIG_LOCAL_TIMERS is not set
 CONFIG_AEABI=y
 CONFIG_LEDS=y
-- 
1.6.0.4
