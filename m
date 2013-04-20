From: vkale@apm.com (Vinayak Kale)
Date: Sat, 20 Apr 2013 12:45:30 +0530
Subject: [PATCH 3/4] arm64: Add defines for APM ARMv8 implementation
In-Reply-To: <1366442131-26094-1-git-send-email-vkale@apm.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
Message-ID: <1366442131-26094-4-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds defines for APM CPU implementer ID and APM CPU part numbers in asm/cputype.h

Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/include/asm/cputype.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index cf27494..5fe138e 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -37,11 +37,14 @@
 })
 
 #define ARM_CPU_IMP_ARM		0x41
+#define ARM_CPU_IMP_APM		0x50
 
 #define ARM_CPU_PART_AEM_V8	0xD0F0
 #define ARM_CPU_PART_FOUNDATION	0xD000
 #define ARM_CPU_PART_CORTEX_A57	0xD070
 
+#define APM_CPU_PART_POTENZA	0x0000
+
 #ifndef __ASSEMBLY__
 
 /*
-- 
1.7.4.1
