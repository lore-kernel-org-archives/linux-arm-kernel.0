From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 23:35:28 +0800
Subject: [GIT PULL] mxs fixes for 3.8
Message-ID: <20130108153526.GA20747@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-fixes-3.8

for you to fetch changes up to 6c1ecba8d84841277d68140ef485335d5be28485:

  video: mxsfb: fix crash when unblanking the display (2013-01-04 19:52:53 +0800)

----------------------------------------------------------------
I have to send one critical mxsfb fix through arm-soc, as FB maintainer
is unresponsive for quite a while.  People start complaining the missing
of such an important fix.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx23-olinuxino: Fix IOMUX settings

Lothar Wa?mann (1):
      video: mxsfb: fix crash when unblanking the display

 arch/arm/boot/dts/imx23-olinuxino.dts |    8 ++++----
 drivers/video/mxsfb.c                 |    3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)
