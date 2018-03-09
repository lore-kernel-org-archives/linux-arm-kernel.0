From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 9 Mar 2018 16:07:16 +0530
Subject: [GIT PULL] DaVinci fixes for v4.16
Message-ID: <e6ec7a59-e577-222b-3c04-5dc6ed9a0821@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.16

for you to fetch changes up to c4dc56be7e26040bfc60ce73425353516a356955:

  ARM: davinci: fix the GPIO lookup for omapl138-hawk (2018-03-09 15:25:40 +0530)

----------------------------------------------------------------
A patch fixing GPIO look-up for MMC/SD card detect and write-protect
pins on OMAP-L138 Hawkboard.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: davinci: fix the GPIO lookup for omapl138-hawk

 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
