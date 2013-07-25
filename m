From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 25 Jul 2013 10:37:33 +0530
Subject: [PATCH v4 2/6] Documentation: exynos5250-clock: Add div_i2s1 and
 div_i2s2
In-Reply-To: <1374728857-4208-1-git-send-email-rahul.sharma@samsung.com>
References: <1374728857-4208-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1374728857-4208-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tushar Behera <tushar.behera@linaro.org>

commit 79d743c177f9 ("clk: exynos5250: Add enum entries for divider
clock of i2s1 and i2s2") added two new clock entries. Add the clock
entry enum numbers to documentation.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 Documentation/devicetree/bindings/clock/exynos5250-clock.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 1a05761..bea503f 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -59,6 +59,8 @@ clock which they consume.
   sclk_spi0		154
   sclk_spi1		155
   sclk_spi2		156
+  div_i2s1		157
+  div_i2s2		158
 
 
    [Peripheral Clock Gates]
-- 
1.7.10.4
