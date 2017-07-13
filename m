From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 13 Jul 2017 11:12:42 +0200
Subject: [PATCH 1/2] pinctrl: zynq: Fix kernel doc warnings
Message-ID: <4c6e1f9b0635682518d2ffa50cf611efef4aff68.1499937148.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the kernel doc warnings in the driver.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/pinctrl/pinctrl-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index b51a46dfdcc3..7565651acdc6 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -45,7 +45,7 @@
  * @syscon:		Syscon regmap
  * @pctrl_offset:	Offset for pinctrl into the @syscon space
  * @groups:		Pingroups
- * @ngroupos:		Number of @groups
+ * @ngroups:		Number of @groups
  * @funcs:		Pinmux functions
  * @nfuncs:		Number of @funcs
  */
-- 
1.9.1
