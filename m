From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:52:01 +0200
Subject: [PATCH 0121/1529] Fix typo
Message-ID: <20160521115201.5707-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-tegra/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 75620ae..d9cd9d5 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -86,7 +86,7 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * For warm boot CPU that was resumed from CPU hotplug, the
 	 * power will be resumed automatically after un-halting the
 	 * flow controller of the warm boot CPU. We need to wait for
-	 * the confirmaiton that the CPU is powered then removing
+	 * the confirmation that the CPU is powered then removing
 	 * the IO clamps.
 	 * For cold boot CPU, do not wait. After the cold boot CPU be
 	 * booted, it will run to tegra_secondary_init() and set
-- 
2.8.2.534.g1f66975
