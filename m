From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 28 May 2013 18:54:30 +0100
Subject: [PATCH v4 2/4] kernel: missing include in cputime.c
In-Reply-To: <alpine.DEB.2.02.1305281835080.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305281835080.4799@kaball.uk.xensource.com>
Message-ID: <1369763672-12919-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org
---
 kernel/sched/cputime.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cc2dc3ee..a5d1a9b 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,6 +5,7 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
+#include <asm/paravirt.h>
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
1.7.2.5
