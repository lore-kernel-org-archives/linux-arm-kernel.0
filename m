From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:12 +0000
Subject: [PATCH 18/29] ARM: KVM: remove superfluous include from kvm_vgic.h
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_vgic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index ab97207..343744e 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -21,7 +21,6 @@
 
 #include <linux/kernel.h>
 #include <linux/kvm.h>
-#include <linux/kvm_host.h>
 #include <linux/irqreturn.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-- 
1.7.12.4
