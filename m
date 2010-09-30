From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Sep 2010 15:46:59 -0700
Subject: [GIT PULL] Couple of omap fixes
Message-ID: <20100930224659.GP3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull two omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:

  Linux 2.6.36-rc6 (2010-09-28 18:01:22 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Scott Ellis (1):
      omap: McBSP: tx_irq_completion used in rx_irq_handler

Tony Lindgren (1):
      omap: Fix compile dependency to LEDS_CLASS

 arch/arm/plat-omap/Kconfig |    2 +-
 arch/arm/plat-omap/mcbsp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
