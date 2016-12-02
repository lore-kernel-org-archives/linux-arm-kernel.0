From: scott.branden@broadcom.com (Scott Branden)
Date: Thu,  1 Dec 2016 16:19:59 -0800
Subject: [RFC PATCH 2/2] arm64: defconfig: enable MEMORY_HOTPLUG config options
In-Reply-To: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
References: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1480637999-4320-3-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable memory hotplug config options to add/remove memory.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..e801b37 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -73,6 +73,9 @@ CONFIG_PCIE_ARMADA_8K=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
+CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA=y
-- 
2.5.0
