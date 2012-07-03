From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 10:00:09 +0800
Subject: [GIT PULL] clk/mxs for 3.6
Message-ID: <20120703020006.GA22106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Here are clk/mxs patches that I have queued for 3.6.  Please pull.

Regards,
Shawn

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git clk/mxs-for-3.6

Fabio Estevam (1):
      clk: mxs: Fix the GPMI clock name

Huang Shijie (1):
      clk: mxs: rename the gpmi clock for imx28

Shawn Guo (1):
      clk: mxs: add clkdev lookup for pwm

 drivers/clk/mxs/clk-imx23.c |    3 ++-
 drivers/clk/mxs/clk-imx28.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
