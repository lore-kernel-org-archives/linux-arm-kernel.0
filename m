From: tony@atomide.com (Tony Lindgren)
Date: Thu, 29 Oct 2015 13:18:30 -0700
Subject: [GIT PULL] two omap regression fixes for v4.3-rc cycle
Message-ID: <20151029201829.GF3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57df5380853460bc66b59a46273ce113c923d39c:

  ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init (2015-10-19 08:55:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc7

for you to fetch changes up to 8f2279d5d908119a08e906be1c6b69c744d0c379:

  usb: musb: omap2430: Fix regression caused by driver core change (2015-10-28 10:16:04 -0700)

----------------------------------------------------------------
Two omap regression fixes:

- Fix omap3 MUSB with DMA caused by driver core changes

- Fix LCD DMA interrupt number for omap1 that did not
  get changed for sparse IRQ changes

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: fix incorrect INT_DMA_LCD

Tony Lindgren (1):
      usb: musb: omap2430: Fix regression caused by driver core change

 drivers/usb/musb/omap2430.c | 29 +++++++++++++++++++++++------
 include/linux/omap-dma.h    |  2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)
