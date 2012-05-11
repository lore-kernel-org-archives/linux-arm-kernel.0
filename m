From: raulxiong@gmail.com (Raul Xiong)
Date: Fri, 11 May 2012 22:54:15 +0800
Subject: [PATCH] cpu_pm: fix some typos in comments
Message-ID: <CAG9bXvkn6bm1xXpBxqvOxxzSrPPRdvP7RzKrfhSVJebN54psHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some comment typos in function names

Signed-off-by: Raul Xiong <raulxiong@gmail.com>
---
 kernel/cpu_pm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 249152e..957b151 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -81,7 +81,7 @@ int cpu_pm_unregister_notifier(struct notifier_block *nb)
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);

 /**
- * cpm_pm_enter - CPU low power entry notifier
+ * cpu_pm_enter - CPU low power entry notifier
 *
 * Notifies listeners that a single CPU is entering a low power state that may
 * cause some blocks in the same power domain as the cpu to reset.
@@ -115,7 +115,7 @@ int cpu_pm_enter(void)
 EXPORT_SYMBOL_GPL(cpu_pm_enter);

 /**
- * cpm_pm_exit - CPU low power exit notifier
+ * cpu_pm_exit - CPU low power exit notifier
 *
 * Notifies listeners that a single CPU is exiting a low power state that may
 * have caused some blocks in the same power domain as the cpu to reset.
@@ -139,7 +139,7 @@ int cpu_pm_exit(void)
 EXPORT_SYMBOL_GPL(cpu_pm_exit);

 /**
- * cpm_cluster_pm_enter - CPU cluster low power entry notifier
+ * cpu_cluster_pm_enter - CPU cluster low power entry notifier
 *
 * Notifies listeners that all cpus in a power domain are entering a low power
 * state that may cause some blocks in the same power domain to reset.
@@ -174,7 +174,7 @@ int cpu_cluster_pm_enter(void)
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);

 /**
- * cpm_cluster_pm_exit - CPU cluster low power exit notifier
+ * cpu_cluster_pm_exit - CPU cluster low power exit notifier
 *
 * Notifies listeners that all cpus in a power domain are exiting form a
 * low power state that may have caused some blocks in the same power domain
