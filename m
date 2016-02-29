From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 16:06:07 +0800
Subject: [GIT PULL] i.MX clock driver update for 4.6
Message-ID: <20160229080607.GT22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

The following are the i.MX clock patches I queued for 4.6.  Please pull
and keep it stable, as I need to pull it into my DT branch to resolve
the dependency on those new clock IDs.

Thanks,
Shawn


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.6

for you to fetch changes up to f6c3aec2f7a218abec9e5c00353abc02224be49e:

  clk: imx: add kpp clock for i.MX6UL (2016-02-28 10:45:29 +0800)

----------------------------------------------------------------
The i.MX clock update for 4.6:
- Add the clock driver support for the latest i.MX6 family SoCs
  addition - i.MX6QP.
- Clean up the whitespace in i.MX6UL clock driver and add the missing
  KPP clock.
- Correct pwm7 clock name in i.MX6UL clock driver.

----------------------------------------------------------------
Anatolij Gustschin (1):
      clk: imx: correct pwm7 clock name in driver for i.MX6UL

Bai Ping (1):
      clk: imx: Add clock support for imx6qp

Lothar Wa?mann (2):
      clk: imx: whitespace cleanup; no functional change
      clk: imx: add kpp clock for i.MX6UL

 drivers/clk/imx/clk-imx6q.c               | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/clk/imx/clk-imx6ul.c              |  65 +++++++++++++++++++++++++++++++++--------------------------------
 include/dt-bindings/clock/imx6qdl-clock.h |  16 +++++++++++++++-
 include/dt-bindings/clock/imx6ul-clock.h  | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------
 4 files changed, 228 insertions(+), 134 deletions(-)
