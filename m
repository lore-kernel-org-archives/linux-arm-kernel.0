From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 25 Aug 2014 14:18:58 +0200
Subject: [PATCH v2 1/2] KVM: EVENTFD: remove inclusion of irq.h
In-Reply-To: <1408969139-14700-1-git-send-email-eric.auger@linaro.org>
References: <1408969139-14700-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1408969139-14700-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more needed. Also irq.h is not used on ARM.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
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
1.9.1
