From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Tue, 11 Apr 2017 15:54:56 +0100
Subject: [PATCH 2/5] arm64: defconfig: enable MEMORY_HOTPLUG config options
In-Reply-To: <cover.1491920513.git.ar@linux.vnet.ibm.com>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
Message-ID: <f1d14a7a96bbaea807551a16395cfbab0702a366.1491920513.git.ar@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Branden <scott.branden@broadcom.com>

Enable memory hotplug config options to add/remove memory.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028..80f48b0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -76,6 +76,9 @@ CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_NUMA=y
 CONFIG_PREEMPT=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
+CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
-- 
1.9.1
