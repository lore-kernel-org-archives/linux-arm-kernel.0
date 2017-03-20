From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 20 Mar 2017 14:15:39 +0800
Subject: [PATCH 0/8] soc: imx: gpc: fixes and clean up
Message-ID: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series mostly fixes a few exist issues and clean up.
1) fix clk error handling to avoid kernel crash
2) fix wrong use of regmap cache
3) fix domain_index sanity check
4) fix mx6sl regression
5) a few clean up

Patch based on shawn/for-next tree.

Dong Aisheng (8):
  soc: imx: gpc: fix gpc clk get error handling
  soc: imx: gpc: fix the wrong using of regmap cache
  soc: imx: gpc: fix domain_index sanity check issue
  soc: imx: gpc: fix imx6sl gpc power domain regression
  soc: imx: gpc: fix comment when power up domain
  soc: imx: gpc: keep PGC_X_CTRL name align with reference manual
  dt-bindings: imx-gpc: correct the DOMAIN_INDEX using
  soc: imx: gpc: remove unnecessary readable_reg callback

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  4 +--
 drivers/soc/imx/gpc.c                              | 36 ++++------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

-- 
2.7.4
