From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 25 Jul 2013 10:37:32 +0530
Subject: [PATCH v4 1/6] clk/exynos5250: Fix HDMI clock number in documentation
In-Reply-To: <1374728857-4208-1-git-send-email-rahul.sharma@samsung.com>
References: <1374728857-4208-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1374728857-4208-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun Kumar K <arun.kk@samsung.com>

This patch corrects the HDMI clock number given wrongly
in the documentation.

Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 Documentation/devicetree/bindings/clock/exynos5250-clock.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 781a627..1a05761 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -154,7 +154,7 @@ clock which they consume.
   dsim0			341
   dp			342
   mixer			343
-  hdmi			345
+  hdmi			344
 
 Example 1: An example of a clock controller node is listed below.
 
-- 
1.7.10.4
