From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Mar 2018 16:41:52 +0800
Subject: [RFC PATCH] net: stmmac: dwmac-sun8i: sun8i_ccu_reg_field can be
 static
In-Reply-To: <20180317092857.4396-10-wens@csie.org>
References: <20180317092857.4396-10-wens@csie.org>
Message-ID: <20180322084152.GA79138@ivytown2.lkp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 0e59c15b2797 ("net: stmmac: dwmac-sun8i: Add support for GMAC on Allwinner R40 SoC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 dwmac-sun8i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index be6705e8..622fb2b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -98,7 +98,7 @@ const struct reg_field sun8i_syscon_reg_field = {
 };
 
 /* EMAC clock register @ 0x164 in the CCU address range */
-const struct reg_field sun8i_ccu_reg_field = {
+static const struct reg_field sun8i_ccu_reg_field = {
 	.reg = 0x164,
 	.lsb = 0,
 	.msb = 31,
