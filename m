From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 28 Mar 2018 09:46:34 +0300
Subject: [RESEND 0/4] Update imx7 clocks
Message-ID: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resent as a patcheset now.

I sent the initial patches as individual ones,
without specifying the order they need to be applied in.

https://lkml.org/lkml/2018/3/27/535
https://lkml.org/lkml/2018/3/27/536
https://lkml.org/lkml/2018/3/27/539
https://lkml.org/lkml/2018/3/27/542


Anson Huang (2):
  clk: imx7d: Correct dram pll type
  clk: imx7d: Correct ahb clk parent select

Dong Aisheng (1):
  clk: imx7d: Move clks_init_on before any clock operations

Peter Chen (1):
  clk: imx7d: Add USB clock information

 drivers/clk/imx/clk-imx7d.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.7.4
