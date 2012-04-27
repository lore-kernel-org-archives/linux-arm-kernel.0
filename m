From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Apr 2012 19:26:17 +0200
Subject: [PULL] ARM: at91: at91sam9n12 DT support
Message-ID: <20120427172617.GX9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull
based on the at91-for-next-dt pull

The following changes since commit 26690863e2c1fa4fee5f6137b219f4b8a1a02287:

  Ethernut 5 board support (2012-04-27 23:23:22 +0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-for-next-soc

for you to fetch changes up to cce783c608fee0716cff65926d1835a5fd097b69:

  ARM: at91: Add DT description files for AT91SAM9N12-EK (2012-04-28 01:40:27 +0800)

----------------------------------------------------------------
ARM: at91: Add at91sam9n12 and refence booard

----------------------------------------------------------------
Hong Xu (3):
      ARM: at91: Add machine header file for AT91SAM9N12 SoC
      ARM: at91: Add machine files for AT91SAM9N12 SoC
      ARM: at91: Add DT description files for AT91SAM9N12-EK

 arch/arm/boot/dts/at91sam9n12.dtsi                 |  221 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts                |   84 +++++++
 arch/arm/mach-at91/Kconfig                         |    8 +
 arch/arm/mach-at91/Makefile                        |    1 +
 arch/arm/mach-at91/Makefile.boot                   |    2 +
 arch/arm/mach-at91/at91sam9n12.c                   |  233 ++++++++++++++++++++
 arch/arm/mach-at91/clock.c                         |   15 +-
 arch/arm/mach-at91/include/mach/at91sam9n12.h      |   60 +++++
 .../mach-at91/include/mach/at91sam9n12_matrix.h    |   53 +++++
 arch/arm/mach-at91/include/mach/cpu.h              |   10 +
 arch/arm/mach-at91/include/mach/hardware.h         |    1 +
 arch/arm/mach-at91/setup.c                         |    6 +
 arch/arm/mach-at91/soc.h                           |    5 +
 13 files changed, 694 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
 create mode 100644 arch/arm/mach-at91/at91sam9n12.c
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h

Best Regards,
J.
