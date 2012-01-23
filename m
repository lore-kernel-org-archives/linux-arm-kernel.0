From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Jan 2012 17:24:01 +0800
Subject: [GIT PULL] imx6: fixes for v3.3-rc
Message-ID: <20120123092359.GA3027@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following patch for v3.3-rc, which is to get rid of
an annoying error message seen on imx6.

Regards,
Shawn

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx6/fixes

Shawn Guo (1):
      ARM: imx6: add missing twd_clk for imx6q clock

 arch/arm/mach-imx/clock-imx6q.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
