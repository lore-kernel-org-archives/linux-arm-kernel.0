From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 12 Jun 2015 16:57:42 -0500
Subject: [PATCH 1/2] arm64: qcom: Add define for ARMv8 implementer (MIDR)
Message-ID: <1434146263-30972-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

This patch adds define for Qualcomm Technologies ARMv8 CPU
implementer ID 0x51 and part number for Kryo in asm/cputype.h.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index a84ec60..6978764 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -64,6 +64,7 @@
 
 #define ARM_CPU_IMP_ARM		0x41
 #define ARM_CPU_IMP_APM		0x50
+#define ARM_CPU_IMP_QCOM	0x51
 
 #define ARM_CPU_PART_AEM_V8	0xD0F
 #define ARM_CPU_PART_FOUNDATION	0xD00
@@ -84,6 +85,9 @@
 #define SCTLR_EL1_CP15BEN	(0x1 << 5)
 #define SCTLR_EL1_SED		(0x1 << 8)
 
+#define QCOM_CPU_PART_MASK	0xF00
+#define QCOM_CPU_PART_KRYO	0x200
+
 #ifndef __ASSEMBLY__
 
 /*
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
