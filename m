From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:18:39 +0900
Subject: [PATCH 05/14 v2] ARM: shmobile: mackerel: Remove mach-type entry
In-Reply-To: <20150126061747.6848.9708.sendpatchset@little-apple>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
Message-ID: <20150126061839.6848.18297.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the mackerel entry from the mach-types file.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - None

 arch/arm/tools/mach-types |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/tools/mach-types
+++ work/arch/arm/tools/mach-types	2015-01-21 12:21:27.377559927 +0900
@@ -526,7 +526,6 @@ ag5evm			MACH_AG5EVM		AG5EVM			3189
 ics_if_voip		MACH_ICS_IF_VOIP	ICS_IF_VOIP		3206
 wlf_cragg_6410		MACH_WLF_CRAGG_6410	WLF_CRAGG_6410		3207
 trimslice		MACH_TRIMSLICE		TRIMSLICE		3209
-mackerel		MACH_MACKEREL		MACKEREL		3211
 kaen			MACH_KAEN		KAEN			3217
 nokia_rm680		MACH_NOKIA_RM680	NOKIA_RM680		3220
 msm8960_sim		MACH_MSM8960_SIM	MSM8960_SIM		3230
