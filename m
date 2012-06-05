From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  5 Jun 2012 15:16:41 +0800
Subject: [PATCH 0/2] A couple of imx6q clock patches
Message-ID: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

These two patches are based on v3.5-rc1 + your imx-clk-common-fixes.
I can wait for your imx-clk-common-fixes hit -rc and then send these
two.  But I think the better approach would be you rebase
imx-clk-common-fixes on -rc1 and then pick up these two into your
fix series.

The first one is a small clean up which can be amended into b0286f2
(ARM: imx6q: prepare and enable init on clks directly instead of
clk_get first), and the second one fixes a suspend regression.

Regards,
Shawn

Shawn Guo (2):
  ARM: imx6q: remove unneeded clkdev lookups
  ARM: imx6q: fix suspend regression caused by common clk migration

 arch/arm/mach-imx/clk-imx6q.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

-- 
1.7.5.4
