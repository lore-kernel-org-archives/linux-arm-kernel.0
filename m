From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Mar 2018 10:05:46 +0800
Subject: [GIT PULL] i.MX clock misc updates for 4.17
Message-ID: <20180313020545.GG26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Michael,

This pull request includes a few random misc i.MX clock driver updates.
As there is no dependency involved, you are free to merge the tag or
cherry-pick the patches.  Thanks.

Shawn


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/clk-imx-4.17-misc

for you to fetch changes up to a5510399e9535b9348adb70c09faa3de51541f9b:

  clk: imx6ull: Add epdc_podf instead of sim_podf (2018-03-13 09:03:14 +0800)

----------------------------------------------------------------
i.MX clock misc updates for 4.17:
 - A correction on i.MX6SX CKO clock mux options.
 - A fix on i.MX7D Video PLL clock tree to include the missing dividers.
 - Update i.MX6UL/ULL clock driver to add epdc_podf instead of sim_podf
   clock for i.MX6ULL.

----------------------------------------------------------------
Anson Huang (2):
      clk: imx: imx6sx: update cko mux options
      clk: imx: imx7d: correct video pll clock tree

Leonard Crestez (1):
      clk: imx6ull: Add epdc_podf instead of sim_podf

 drivers/clk/imx/clk-imx6sx.c | 14 ++++----
 drivers/clk/imx/clk-imx6ul.c |  5 ++-
 drivers/clk/imx/clk-imx7d.c  | 84 +++++++++++++++++++++++---------------------
 3 files changed, 55 insertions(+), 48 deletions(-)
