From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 27 Jan 2016 15:26:03 +0800
Subject: [PATCH] clk: Move vendor's Kconfig into CCF menu section
Message-ID: <1453879563-39500-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all vendor's Kconfig into CCF menu section to prevent
new drivers putting their Kconfig files in a wrong place.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index eca8e01..de707b2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -202,11 +202,9 @@ config COMMON_CLK_CDCE706
 
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
-source "drivers/clk/qcom/Kconfig"
-
-endmenu
-
 source "drivers/clk/mvebu/Kconfig"
-
+source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/tegra/Kconfig"
+
+endmenu
-- 
1.9.1
