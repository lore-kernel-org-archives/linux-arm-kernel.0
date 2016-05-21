From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:53:22 +0200
Subject: [PATCH 0131/1529] Fix typo
Message-ID: <20160521115322.6241-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm64/kvm/guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 32fad75..3f9e157 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -211,7 +211,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 /**
  * kvm_arm_copy_reg_indices - get indices of all registers.
  *
- * We do core registers right here, then we apppend system regs.
+ * We do core registers right here, then we append system regs.
  */
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-- 
2.8.2.534.g1f66975
