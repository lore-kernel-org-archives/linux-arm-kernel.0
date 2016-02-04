From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  4 Feb 2016 11:00:45 +0000
Subject: [PATCH v2 28/28] ARM: KVM: Remove __kvm_hyp_exit/__kvm_hyp_exit_end
In-Reply-To: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454583645-10144-29-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have no idea what these were for - probably a leftover from an
early implementation. Good bye!

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 083825f..15d58b4 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -55,9 +55,6 @@ struct kvm_vcpu;
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
 
-extern char __kvm_hyp_exit[];
-extern char __kvm_hyp_exit_end[];
-
 extern char __kvm_hyp_vector[];
 
 extern void __kvm_flush_vm_context(void);
-- 
2.1.4
