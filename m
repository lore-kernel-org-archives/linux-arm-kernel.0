From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:52 +0200
Subject: [PATCH 0093/1529] Fix typo
Message-ID: <20160521114852.4176-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/kvm/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index 0048b5a..4b5e802 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -52,7 +52,7 @@ static const struct kvm_irq_level cortexa_vtimer_irq = {
  * @vcpu: The VCPU pointer
  *
  * This function finds the right table above and sets the registers on the
- * virtual CPU struct to their architectually defined reset values.
+ * virtual CPU struct to their architecturally defined reset values.
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
-- 
2.8.2.534.g1f66975
