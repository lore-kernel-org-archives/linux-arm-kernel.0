From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 2 Jul 2018 21:31:17 +0000
Subject: [PATCH v2 1/2] clk: meson-axg: add pcie and mipi clock bindings
In-Reply-To: <20180702213118.19222-1-yixun.lan@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
Message-ID: <20180702213118.19222-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pcie and mipi clock dt-bindings for the pcie driver.

Since the mipi clock isalso used by the pcie driver,
we add it together in this patch.

Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 include/dt-bindings/clock/axg-clkc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index 555937a25504..70371228b7e0 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -68,5 +68,8 @@
 #define CLKID_SD_EMMC_B_CLK0			59
 #define CLKID_SD_EMMC_C_CLK0			60
 #define CLKID_HIFI_PLL				69
+#define CLKID_PCIE_CML_EN0			79
+#define CLKID_PCIE_CML_EN1			80
+#define CLKID_MIPI_ENABLE			81
 
 #endif /* __AXG_CLKC_H */
-- 
2.18.0
