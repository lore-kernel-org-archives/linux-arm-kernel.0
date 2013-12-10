From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Dec 2013 20:49:00 -0800
Subject: [GIT PULL] wl1251 platform data changes for v3.14
Message-ID: <pull-1386650940-122495>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 736e812636ea72be444b85fa7e92554967459069:

  ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-wl1251

for you to fetch changes up to ce226391aec803a49b39c22d3385057c9db02f30:

  Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal (2013-12-09 19:39:51 -0800)

----------------------------------------------------------------

Minimal changes for the wl151 platform data that would otherwise
cause merge conflicts between the wireless tree and linux-omap
tree. This was discussed on the mailing lists here:

http://www.spinics.net/lists/linux-omap/msg99906.html

----------------------------------------------------------------
Luciano Coelho (1):
      wl1251: split wl251 platform data to a separate structure

Sebastian Reichel (1):
      wl1251: move power GPIO handling into the driver

Tony Lindgren (1):
      Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal

 drivers/net/wireless/ti/wilink_platform_data.c | 37 +++++++++++++++++++++-----
 drivers/net/wireless/ti/wl1251/sdio.c          | 31 ++++++++++++++-------
 drivers/net/wireless/ti/wl1251/spi.c           | 35 +++++++++++++++---------
 drivers/net/wireless/ti/wl1251/wl1251.h        |  2 +-
 include/linux/wl12xx.h                         | 24 +++++++++++++++--
 5 files changed, 97 insertions(+), 32 deletions(-)
