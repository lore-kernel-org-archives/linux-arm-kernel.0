From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 17 Dec 2010 14:56:27 -0500 (EST)
Subject: Git pull request: Orion and friends update for next merge window
Message-ID: <alpine.LFD.2.00.1012171450240.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you pull:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

To receive the following:

Ash Hughes (1):
      [ARM] Orion: added Buffalo LS-CHL support

Evgeniy Dushistov (1):
      [ARM] mv78xx: wrong cpu1 window base register address

Konstantin Sinyuk (1):
      [ARM] Dove: add support for CM-A510 machine.

Martin Michlmayr (1):
      Kirkwood: Add support for 6282 based QNAP devices

Mike Rapoport (2):
      [ARM] Dove: add support for GPIOs 64-71
      [ARM] Dove: add support for multi-purpose pins configuration

 arch/arm/mach-dove/Kconfig                   |    6 +
 arch/arm/mach-dove/Makefile                  |    3 +-
 arch/arm/mach-dove/cm-a510.c                 |   95 ++++++
 arch/arm/mach-dove/include/mach/dove.h       |    9 +-
 arch/arm/mach-dove/include/mach/gpio.h       |    6 +-
 arch/arm/mach-dove/mpp.c                     |  212 +++++++++++++
 arch/arm/mach-dove/mpp.h                     |  220 +++++++++++++
 arch/arm/mach-kirkwood/Kconfig               |   12 +-
 arch/arm/mach-kirkwood/ts219-setup.c         |   16 +-
 arch/arm/mach-kirkwood/ts41x-setup.c         |    9 +
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h |    2 +-
 arch/arm/mach-orion5x/Kconfig                |    7 +
 arch/arm/mach-orion5x/Makefile               |    1 +
 arch/arm/mach-orion5x/ls-chl-setup.c         |  327 ++++++++++++++++++++
 14 files changed, 912 insertions(+), 13 deletions(-)

Nicolas
