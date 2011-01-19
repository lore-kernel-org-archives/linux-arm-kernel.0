From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 12:25:41 -0800
Subject: [PATCH v2 05/11] msm: Physical offset for MSM8960
In-Reply-To: <1295468747-22796-1-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1295468747-22796-6-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stepan Moskovchenko <stepanm@codeaurora.org>

Add the physical memory offset value for the Qualcomm
MSM8960 chip.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
index 070e17d..014bbd3 100644
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ b/arch/arm/mach-msm/include/mach/memory.h
@@ -25,6 +25,8 @@
 #define PHYS_OFFSET		UL(0x00200000)
 #elif defined(CONFIG_ARCH_MSM8X60)
 #define PHYS_OFFSET		UL(0x40200000)
+#elif defined(CONFIG_ARCH_MSM8960)
+#define PHYS_OFFSET		UL(0x40200000)
 #else
 #define PHYS_OFFSET		UL(0x10000000)
 #endif
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
