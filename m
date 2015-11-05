From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 5 Nov 2015 10:40:51 +0800
Subject: [PATCH] ARM: Xen: Fix the file name in comment
Message-ID: <1446691251-13804-1-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

These hypercalls are located in hypercall.S not hypervisor.S file.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm/xen/enlighten.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index eeeab07..5421706 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -284,7 +284,7 @@ void xen_arch_resume(void) { }
 void xen_arch_suspend(void) { }
 
 
-/* In the hypervisor.S file. */
+/* In the hypercall.S file. */
 EXPORT_SYMBOL_GPL(HYPERVISOR_event_channel_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_grant_table_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_xen_version);
-- 
2.0.4
