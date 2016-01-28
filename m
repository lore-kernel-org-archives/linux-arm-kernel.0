From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jan 2016 10:30:37 +0000
Subject: [PATCH 4/5] arm64: KVM: Fix comments of the CP handler
In-Reply-To: <1453977038-13516-1-git-send-email-marc.zyngier@arm.com>
References: <1453977038-13516-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1453977038-13516-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Make sure the documentation reflects the actual name of the functions.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index eec3598..4048934 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1043,7 +1043,7 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
 }
 
 /**
- * kvm_handle_cp_64 -- handles a mrrc/mcrr trap on a guest CP15 access
+ * kvm_handle_cp_64 -- handles a mrrc/mcrr trap on a guest CP14/CP15 access
  * @vcpu: The VCPU pointer
  * @run:  The kvm_run struct
  */
@@ -1095,7 +1095,7 @@ out:
 }
 
 /**
- * kvm_handle_cp15_32 -- handles a mrc/mcr trap on a guest CP15 access
+ * kvm_handle_cp_32 -- handles a mrc/mcr trap on a guest CP14/CP15 access
  * @vcpu: The VCPU pointer
  * @run:  The kvm_run struct
  */
-- 
2.1.4
