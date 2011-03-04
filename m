From: sheetals@codeaurora.org (Sheetal Sahasrabudhe)
Date: Fri,  4 Mar 2011 17:10:47 -0500
Subject: [PATCH 3/3] [ARM] Oprofile: Add Qualcomm Scorpion and ScorpionMP CPU
	type
Message-ID: <1299276647-12958-1-git-send-email-sheetals@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds Qualcomm Scorpion and ScorpionMP CPU type
to Oprofile kernel driver.

Signed-off-by: Sheetal Sahasrabudhe <sheetals@codeaurora.org>
---
 arch/arm/oprofile/common.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index c074e66..1a04f07 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -40,6 +40,10 @@ char *op_name_from_perf_id(void)
 		return "arm/armv7";
 	case ARM_PERF_PMU_ID_CA9:
 		return "arm/armv7-ca9";
+	case ARM_PERF_PMU_ID_SCORPION:
+		return "arm/armv7-scorpion";
+	case ARM_PERF_PMU_ID_SCORPIONMP:
+		return "arm/armv7-scorpionmp";
 	default:
 		return NULL;
 	}
-- 
1.7.4.1

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
