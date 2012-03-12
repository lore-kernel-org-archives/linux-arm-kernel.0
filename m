From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 09:52:13 +0530
Subject: [PATCH V2 18/22] watchdog/sp805: Fix documentation style comment
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
Message-ID: <9928ca5b3a445b49a693dd7be48e09359cda1c94.1331524811.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

@ was missing before variables names, in their description. Also adev is
mentioned as dev in comment. Fix both these issues.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index e2d5249..7af1386 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -56,14 +56,13 @@
 
 /**
  * struct sp805_wdt: sp805 wdt device structure
- *
- * lock: spin lock protecting dev structure and io access
- * base: base address of wdt
- * clk: clock structure of wdt
- * dev: amba device structure of wdt
- * status: current status of wdt
- * load_val: load value to be set for current timeout
- * timeout: current programmed timeout
+ * @lock: spin lock protecting dev structure and io access
+ * @base: base address of wdt
+ * @clk: clock structure of wdt
+ * @adev: amba device structure of wdt
+ * @status: current status of wdt
+ * @load_val: load value to be set for current timeout
+ * @timeout: current programmed timeout
  */
 struct sp805_wdt {
 	spinlock_t			lock;
-- 
1.7.8.110.g4cb5d
