From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 23 Mar 2018 22:38:10 +0800
Subject: [PATCH v2 1/7] clk: meson: drop meson_aoclk_gate_regmap_ops
In-Reply-To: <20180323143816.200573-1-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
Message-ID: <20180323143816.200573-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

let's remove the unused meson_aoclk_gate_regmap_ops

Fixes: 1f932d99710d ("clk: meson: remove superseded aoclk_gate_regmap")
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb-aoclk.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index 0be78383f257..badc4c22b4ee 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -17,8 +17,6 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-extern const struct clk_ops meson_aoclk_gate_regmap_ops;
-
 struct aoclk_cec_32k {
 	struct clk_hw hw;
 	struct regmap *regmap;
-- 
2.15.1
