From: david@lechnology.com (David Lechner)
Date: Fri, 18 May 2018 11:48:16 -0500
Subject: [PATCH v11 14/27] ARM: davinci_all_defconfig: remove
 CONFIG_DAVINCI_RESET_CLOCKS
In-Reply-To: <20180518164829.27052-1-david@lechnology.com>
References: <20180518164829.27052-1-david@lechnology.com>
Message-ID: <20180518164829.27052-15-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes CONFIG_DAVINCI_RESET_CLOCKS. The option has been removed from
the kernel.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v11 changes:
- none

v10 changes:
- none

v9 changes:
- none

v8 changes:
- none

v7 changes:
- none

v6 changes:
- none


 arch/arm/configs/davinci_all_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 21b2d7791df4..f83ea4131df2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -31,7 +31,6 @@ CONFIG_MACH_MITYOMAPL138=y
 CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_DAVINCI_RESET_CLOCKS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_CMA=y
-- 
2.17.0
