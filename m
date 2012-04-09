From: robherring2@gmail.com (Rob Herring)
Date: Mon,  9 Apr 2012 15:24:59 -0500
Subject: [PATCH 2/4] clk: remove trailing whitespace from clk.h
In-Reply-To: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
Message-ID: <1334003101-17274-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove trailing whitespace from 2 lines.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/clk.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index b025272..e08bff1 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -220,7 +220,7 @@ void clk_put(struct clk *clk);
  * Returns rounded clock rate in Hz, or negative errno.
  */
 long clk_round_rate(struct clk *clk, unsigned long rate);
- 
+
 /**
  * clk_set_rate - set the clock rate for a clock source
  * @clk: clock source
@@ -229,7 +229,7 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
  * Returns success (0) or negative errno.
  */
 int clk_set_rate(struct clk *clk, unsigned long rate);
- 
+
 /**
  * clk_set_parent - set the parent clock source for this clock
  * @clk: clock source
-- 
1.7.5.4
