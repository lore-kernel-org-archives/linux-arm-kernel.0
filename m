From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:06 +0900
Subject: [PATCH 05/12] ARM: shmobile: mackerel: Remove mach-type entry
In-Reply-To: <cover.1424931560.git.horms+renesas@verge.net.au>
References: <cover.1424931560.git.horms+renesas@verge.net.au>
Message-ID: <34dc938f4ddd39851ecd2f1d21c431e6c3e3baa2.1424931560.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the mackerel entry from the mach-types file.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/tools/mach-types | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index a10297d..2ed1b8a 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -526,7 +526,6 @@ ag5evm			MACH_AG5EVM		AG5EVM			3189
 ics_if_voip		MACH_ICS_IF_VOIP	ICS_IF_VOIP		3206
 wlf_cragg_6410		MACH_WLF_CRAGG_6410	WLF_CRAGG_6410		3207
 trimslice		MACH_TRIMSLICE		TRIMSLICE		3209
-mackerel		MACH_MACKEREL		MACKEREL		3211
 kaen			MACH_KAEN		KAEN			3217
 nokia_rm680		MACH_NOKIA_RM680	NOKIA_RM680		3220
 msm8960_sim		MACH_MSM8960_SIM	MSM8960_SIM		3230
-- 
2.1.4
