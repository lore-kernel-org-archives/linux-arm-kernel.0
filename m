From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:46 +0200
Subject: [PATCH 0092/1529] Fix typo
Message-ID: <20160521114846.4126-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/kvm/guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 9093ed0..9aca920 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -182,7 +182,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 /**
  * kvm_arm_copy_reg_indices - get indices of all registers.
  *
- * We do core registers right here, then we apppend coproc regs.
+ * We do core registers right here, then we append coproc regs.
  */
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-- 
2.8.2.534.g1f66975
