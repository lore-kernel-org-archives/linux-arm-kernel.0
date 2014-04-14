From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 14 Apr 2014 16:40:36 +0900
Subject: [PATCH 2/8] arm/arm64: KVM: Fix line length exceeding 80 characters
Message-ID: <000001cf57b4$d3450780$79cf1680$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch deals with checkpatch complaint as fixing line length
exceeding 80 characters.

WARNING: line over 80 characters

Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
---
 arch/arm/kvm/mmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 80bb1e6..e0d4f24 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -563,8 +563,8 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 	kvm->arch.pgd = NULL;
 }
 
-static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
-			     phys_addr_t addr)
+static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache
+			     *cache, phys_addr_t addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
-- 
1.7.10.4
