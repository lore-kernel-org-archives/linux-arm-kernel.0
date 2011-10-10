From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 10 Oct 2011 13:44:51 -0600 (MDT)
Subject: [GIT PULL] ARM: OMAP: new miscellaneous clock/hwmod data for 3.2
Message-ID: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit be73246058737beec52ae232bcab7776332a9e06:

  ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2

Benoit Cousson (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP4

Keshava Munegowda (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP3

Paul Walmsley (1):
      ARM: OMAP3xxx: hwmod data: add PRM hwmod

Santosh Shilimkar (1):
      ARM: OMAP4: clock: Add CPU local timer clock node.

 arch/arm/mach-omap2/clock44xx_data.c       |    9 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  279 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  206 ++++++++++++++++++++-
 3 files changed, 493 insertions(+), 1 deletions(-)


- Paul
