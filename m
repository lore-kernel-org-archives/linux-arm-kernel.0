From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 19 Oct 2015 17:55:49 +0100
Subject: [PATCH] ARM64: Enable multi-core scheduler support by default
Message-ID: <1445273749-16778-1-git-send-email-dietmar.eggemann@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that the task scheduler domain hierarchy is set-up correctly
on systems with single or multi-cluster topology.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd86781..dc70d715bc38 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -51,6 +51,7 @@ CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_XGENE=y
 CONFIG_SMP=y
+CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
-- 
1.9.1
