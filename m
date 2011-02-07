From: mike@compulab.co.il (Mike Rapoport)
Date: Mon,  7 Feb 2011 10:10:52 +0200
Subject: [PATCH 1/2] ARM: update trimslice entry in the machine registry
In-Reply-To: <cover.1297063443.git.mike@compulab.co.il>
References: <cover.1297063443.git.mike@compulab.co.il>
Message-ID: <354f589cbbf0b58d0383b07f5e221fa3a6f5d23c.1297063443.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/tools/mach-types |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 2fea897..bda8b81 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -3190,7 +3190,7 @@ synergy			MACH_SYNERGY		SYNERGY			3205
 ics_if_voip		MACH_ICS_IF_VOIP	ICS_IF_VOIP		3206
 wlf_cragg_6410		MACH_WLF_CRAGG_6410	WLF_CRAGG_6410		3207
 punica			MACH_PUNICA		PUNICA			3208
-sbc_nt250		MACH_SBC_NT250		SBC_NT250		3209
+trimslice		MACH_TRIMSLICE		TRIMSLICE		3209
 mx27_wmultra		MACH_MX27_WMULTRA	MX27_WMULTRA		3210
 mackerel		MACH_MACKEREL		MACKEREL		3211
 fa9x27			MACH_FA9X27		FA9X27			3213
-- 
1.7.3.1
