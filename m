From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 11 Apr 2012 18:02:48 -0700
Subject: [PATCH 10/13] clk: Remove comment for end of CONFIG_COMMON_CLK section
In-Reply-To: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
Message-ID: <1334192572-12499-11-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

The comment is inaccurate (it actually ends the CONFIG_COMMON_CLK
section, there's no else) and given that we've just got a single level
of ifdef isn't really needed anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
Cc: Arnd Bergman <arnd.bergmann@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Richard Zhao <richard.zhao@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/clk.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index b025272..c9547d9 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -81,7 +81,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
 
 int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
 
-#endif /* !CONFIG_COMMON_CLK */
+#endif
 
 /**
  * clk_get - lookup and obtain a reference to a clock producer.
-- 
1.7.5.4
