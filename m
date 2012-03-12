From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 09:52:03 +0530
Subject: [PATCH V2 08/22] watchdog/mpcore_wdt: Arrange #includes in
 alphabetical order
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
Message-ID: <352721112bf538b960d5b642570d64c286760c49.1331524811.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7c9f78c..1c37109 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -17,16 +17,16 @@
  *
  * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/watchdog.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
-#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
 
 #include <asm/smp_twd.h>
 
-- 
1.7.8.110.g4cb5d
