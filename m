From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 14:46:49 -0800
Subject: [GIT PULL] Two non-critical DMA fixes for v3.3 merge window
Message-ID: <20111212224648.GI32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please pull two non-critical DMA fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical

These are workarounds for corner cases. There's no rush
to get them in during the -rc cycle, these are fixes for
features that never worked before.

Regards,

Tony


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
  Linus Torvalds (1):
        Linux 3.2-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical

Peter Ujfalusi (2):
      ARM: OMAP2+: DMA: Workaround for invalid source position
      ARM: OMAP2+: DMA: Workaround for invalid destination position

 arch/arm/plat-omap/dma.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)
