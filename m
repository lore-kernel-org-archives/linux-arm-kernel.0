From: stigge@antcom.de (Roland Stigge)
Date: Wed, 07 Nov 2012 13:52:34 +0100
Subject: [GIT PULL] arm-soc: lpc32xx: platform updates
Message-ID: <509A5992.60009@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this pull request includes the platform topic branch for lpc32xx.

Thanks in advance,

Roland


The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core

for you to fetch changes up to 91deef8069e7ffafac4467200e1d37af1b2d7c56:

  ARM: LPC32xx: Cleanup irq.c (2012-11-07 13:30:50 +0100)

----------------------------------------------------------------
Roland Stigge (3):
      ARM: LPC32xx: Remove superfluous irq_alloc_descs()
      ARM: LPC32xx: Relocate calls to irq_set_chained_handler()
      ARM: LPC32xx: Cleanup irq.c

 arch/arm/mach-lpc32xx/irq.c |   23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)
