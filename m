From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 1 Mar 2012 14:28:57 +0100
Subject: [PATCH 3/4] amba: use the new linux/sizes.h
In-Reply-To: <cover.1330607068.git.rubini@gnudd.com>
References: <cover.1330607068.git.rubini@gnudd.com>
Message-ID: <77a3185dda7be993be3538c9e5cc59e6d95f14aa.1330607068.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/amba/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 01c2cf4..d7fe84a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,7 +18,7 @@
 #include <linux/amba/bus.h>
 
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-- 
1.7.7.2
