From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:43 +0200
Subject: [PATCH 10/27] KVM: EVENTFD: remove inclusion of irq.h
In-Reply-To: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
References: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1411737420-9063-11-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

No more needed. irq.h would be void on ARM.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/eventfd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 3c5981c..0c712a7 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -36,7 +36,6 @@
 #include <linux/seqlock.h>
 #include <trace/events/kvm.h>
 
-#include "irq.h"
 #include "iodev.h"
 
 #ifdef CONFIG_HAVE_KVM_IRQFD
-- 
2.0.0
