From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Fri, 2 Nov 2012 18:43:36 +0800
Subject: [PATCH 1/1] ARM: oprofile: add A5/A7/A15 entries in op_perf_name
Message-ID: <1351853016-4476-1-git-send-email-jgq516@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiao Jiang <jgq516@gmail.com>

Add related name for A5/A7/A15 which are consistent with the OProfile
user ABI.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 arch/arm/oprofile/common.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 99c63d4b..ec10db1 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -37,8 +37,11 @@ static struct op_perf_name {
 	{ "xscale1",		"arm/xscale2"	},
 	{ "v6",			"arm/armv6"	},
 	{ "v6mpcore",		"arm/mpcore"	},
+	{ "ARMv7 Cortex-A5",	"arm/armv7-ca5"	},
+	{ "ARMv7 Cortex-A7",	"arm/armv7-ca7"	},
 	{ "ARMv7 Cortex-A8",	"arm/armv7"	},
 	{ "ARMv7 Cortex-A9",	"arm/armv7-ca9"	},
+	{ "ARMv7 Cortex-A15",	"arm/armv7-ca15" },
 };
 
 char *op_name_from_perf_id(void)
-- 
1.7.3
