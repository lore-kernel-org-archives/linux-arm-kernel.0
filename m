From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 15:42:40 +0800
Subject: [GIT PULL] clk/mxs for 3.6 (part 2)
Message-ID: <20120712074238.GK6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Here is one more clk/mxs patch (last one, I believe) for 3.6.
Please pull.

Regards,
Shawn

The following changes since commit 64e2bc41304726a5ca8a4d37754db69b88841ebf:

  clk: mxs: imx28: decrease the frequency of ref_io1 for SSP2 and SSP3 (2012-07-05 09:36:44 +0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git clk/mxs-for-3.6

Richard Zhao (1):
      clk: mxs: clk_register_clkdev mx28 usb clocks

 drivers/clk/mxs/clk-imx28.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
