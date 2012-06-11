From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 12:47:15 +0800
Subject: [GIT PULL] imx fixes for v3.5-rc (part 2)
In-Reply-To: <20120611044359.GD2344@S2101-09.ap.freescale.net>
References: <20120611044359.GD2344@S2101-09.ap.freescale.net>
Message-ID: <CAAQ0ZWQ1D38onzk0aMaCTEQ-NSyCgEEUNwK3PfWbE2VUSG2ckQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are a couple of imx6q clk patches missed from Sascha's
imx-common-clk-fixes pull-request.  So I rebase them on arm-soc/fixes
(they depends on one patch in Sascha's pull-request) and send them
here.  Please pull.  Thanks.

Regards,
Shawn

The following changes since commit f9c15a1b7d60b69f42b2808140a4713808a3bec1:

  Merge tag 'omap-fixes-for-v3.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
fixes (2012-06-08 00:43:39 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/fixes-for-3.5

Shawn Guo (2):
      ARM: imx6q: remove unneeded clkdev lookups
      ARM: imx6q: fix suspend regression caused by common clk migration

 arch/arm/mach-imx/clk-imx6q.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)
