From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 9 Nov 2011 16:57:22 +0100
Subject: [AT91 PULL] at91 fixes pull request
Message-ID: <20111109155722.GA17366@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

	this is some fixes for the 3.2

The following changes since commit 19e0bafc36abd84a5b4d7c7745b78a6f4626e944:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux (2011-11-08 18:34:16 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git at91-fixes

Jean-Christophe PLAGNIOL-VILLARD (4):
      ARM: at91: usart: drop static map regs for dbgu
      at91: vmalloc fix missing AT91_VIRT_BASE define
      at91/yl-9200: Fix section mismatch
      atmel/spi: fix missing probe

Jochen Friedrich (1):
      ARM: at91: Fix USBA gadget registration

 arch/arm/mach-at91/at91cap9_devices.c     |    7 +++----
 arch/arm/mach-at91/at91rm9200_devices.c   |    5 ++---
 arch/arm/mach-at91/at91sam9260_devices.c  |    5 ++---
 arch/arm/mach-at91/at91sam9261_devices.c  |    5 ++---
 arch/arm/mach-at91/at91sam9263_devices.c  |    5 ++---
 arch/arm/mach-at91/at91sam9g45_devices.c  |    7 +++----
 arch/arm/mach-at91/at91sam9rl_devices.c   |    7 +++----
 arch/arm/mach-at91/board-yl-9200.c        |    2 +-
 arch/arm/mach-at91/include/mach/vmalloc.h |    2 ++
 drivers/spi/spi-atmel.c                   |    5 +++--
 10 files changed, 23 insertions(+), 27 deletions(-)

Best Regards,
J.
