From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 16:28:27 +0800
Subject: [GIT PULL] i.MX clock update for 4.8
Message-ID: <20160628082827.GG21328@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.8

for you to fetch changes up to bfa10f7d9ae2a6d1e615bf6841887fd9adb056be:

  clk: imx6ul: fix gpt2 clock names (2016-06-16 09:05:55 +0800)

----------------------------------------------------------------
The i.MX clock updates for 4.8:
 - A few correction and improvements on pllv3 driver around AV pll clock
   rate calculation, parent setting and power bit handling
 - Correct i.MX6UL GPT2 clock names
 - A couple of minor fixes on i.MX7D clock driver on DRAM clocks

----------------------------------------------------------------
Anson Huang (3):
      clk: imx: correct AV PLL rate formula
      clk: imx7d: correct dram root clk parent select
      clk: imx7d: correct dram pll type

Dong Aisheng (4):
      clk: imx: fix pll clock parents
      clk: imx: clk-pllv3: fix incorrect handle of enet powerdown bit
      clk: imx: refine the powerdown bit of clk-pllv3
      clk: imx6ul: fix gpt2 clock names

 drivers/clk/imx/clk-imx6q.c  | 14 +++++++-------
 drivers/clk/imx/clk-imx6sl.c | 14 +++++++-------
 drivers/clk/imx/clk-imx6sx.c | 14 +++++++-------
 drivers/clk/imx/clk-imx6ul.c | 18 +++++++++---------
 drivers/clk/imx/clk-imx7d.c  | 14 +++++++-------
 drivers/clk/imx/clk-pllv3.c  | 28 ++++++++++++++++------------
 6 files changed, 53 insertions(+), 49 deletions(-)
