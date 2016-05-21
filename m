From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:53:30 +0200
Subject: [PATCH 0132/1529] Fix typo
Message-ID: <20160521115330.6299-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm64/kvm/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b1ad730..7be24f2 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -98,7 +98,7 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
  * @vcpu: The VCPU pointer
  *
  * This function finds the right table above and sets the registers on
- * the virtual CPU struct to their architectually defined reset
+ * the virtual CPU struct to their architecturally defined reset
  * values.
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
-- 
2.8.2.534.g1f66975
