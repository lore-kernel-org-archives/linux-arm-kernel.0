From: mturquette@linaro.org (Mike Turquette)
Date: Sat,  3 Mar 2012 00:28:59 -0800
Subject: [PATCH v5 2/4] clk: Kconfig: add entry for HAVE_CLK_PREPARE
In-Reply-To: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
Message-ID: <1330763341-3437-3-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clk framework provides clk_prepare and clk_unprepare
implementations.  Create an entry for HAVE_CLK_PREPARE so that
COMMON_CLK can select it.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Mike Turquette <mturquette@ti.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergman <arnd.bergmann@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Richard Zhao <richard.zhao@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Deepak Saxena <dsaxena@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/clk/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9b3cd08..3912576 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -8,3 +8,6 @@ config HAVE_CLK_PREPARE
 
 config HAVE_MACH_CLKDEV
 	bool
+
+config HAVE_CLK_PREPARE
+	bool
-- 
1.7.5.4
