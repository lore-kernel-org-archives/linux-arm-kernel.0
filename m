From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Jan 2013 22:44:01 +0800
Subject: [GIT PULL] imx fixes for 3.8, take 3
Message-ID: <20130122144358.GC2812@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 83ae20981ae924c37d02a42c829155fc3851260c:

  ARM: imx: correct low-power mode setting (2013-01-14 22:19:48 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.8-3

for you to fetch changes up to e6b267ce14f61d9da0151b97ee26ab4d38055567:

  video: imxfb: Do not crash on reboot (2013-01-17 16:14:29 +0800)

----------------------------------------------------------------
This is yet another critical imxfb fixes held off by absence of FB
maintainer for some time.

----------------------------------------------------------------
Fabio Estevam (1):
      video: imxfb: Do not crash on reboot

 drivers/video/imxfb.c |   10 ++++++++++
 1 file changed, 10 insertions(+)
