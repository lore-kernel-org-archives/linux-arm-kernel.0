From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:35 +0530
Subject: [PATCH 03/13] clk: Fix typo in comment
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <0129313aa0efde5b3ab818e0f8bd13da70851f4d.1334660431.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_MUX_INDEX_BIT is mistakenly written as CLK_MUX_INDEX_BITWISE in comment. Fix
it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/clk-provider.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d98bdbc..8bb93c4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -239,7 +239,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
  *
  * Flags:
  * CLK_MUX_INDEX_ONE - register index starts at 1, not 0
- * CLK_MUX_INDEX_BITWISE - register index is a single bit (power of two)
+ * CLK_MUX_INDEX_BIT - register index is a single bit (power of two)
  */
 struct clk_mux {
 	struct clk_hw	hw;
-- 
1.7.9
