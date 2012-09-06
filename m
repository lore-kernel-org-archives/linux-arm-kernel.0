From: stigge@antcom.de (Roland Stigge)
Date: Thu, 06 Sep 2012 13:58:14 +0200
Subject: [GIT PULL] ARM: LPC32xx: core update
Message-ID: <50488FD6.4080402@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

below is the LPC32xx core update branch for 3.7.

Thanks,

Roland



The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core

for you to fetch changes up to 7a5deff68f9e0a1db170ac9dd3b2b4aaddc1b80c:

  ARM: LPC32xx: Remove board specific GPIO init (2012-09-06 11:39:29 +0200)

----------------------------------------------------------------
Roland Stigge (3):
      ARM: LPC32xx: Use handle_edge_irq() callback on edge type irqs
      ARM: LPC32xx: Provide DMA filter callbacks via platform data
      ARM: LPC32xx: Remove board specific GPIO init

 arch/arm/mach-lpc32xx/irq.c     |    7 ++++---
 arch/arm/mach-lpc32xx/phy3250.c |   20 ++++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)
