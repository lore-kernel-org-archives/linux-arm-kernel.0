From: rubini@gnudd.com (Alessandro Rubini)
Date: Mon, 28 May 2012 18:37:25 +0200
Subject: [PATCH V2 2/6] amba: use the new linux/sizes.h
In-Reply-To: <cover.1338222460.git.rubini@gnudd.com>
References: <cover.1338222460.git.rubini@gnudd.com>
Message-ID: <47bf886a2bc4d9e65b14a5700d5aa874232ec32a.1338222461.git.rubini@gnudd.com>
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
index b7e7285..e8eb91b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -16,9 +16,9 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
+#include <linux/sizes.h>
 
 #include <asm/irq.h>
-#include <asm/sizes.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-- 
1.7.7.2
