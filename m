From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 20 Oct 2010 13:06:42 +0200
Subject: [GITT PULL] AT91: second pull for 2.6.37 merge window
Message-ID: <4CBECD42.7070905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Could you please pull the following:

  git://github.com/at91linux/linux-2.6-at91.git for_rmk_bis

This contains second set of AT91 update for 2.6.37 
merge window. All has been discussed on the list. 
It is based on latest linus' git tree:
commit 51ea8a88aae425915b458bfe295f1f10a3d52781

Nicolas Ferre (3):
      AT91: trivial: align comment of at91sam9g20_reset with one more tab
      AT91: reset routine cleanup, remove not needed icache flush
      AT91: reset: extend alternate reset procedure to several chips

Peter Gsellmann (1):
      AT91: add board support for Pcontrol_G20

Peter Horton (1):
      AT91: Fix AT91SAM9G20 reset as per the errata in the data sheet

 arch/arm/configs/pcontrol_g20_defconfig |  175 +++++++++++++++++
 arch/arm/mach-at91/Kconfig              |    6 +
 arch/arm/mach-at91/Makefile             |   13 +-
 arch/arm/mach-at91/at91sam9260.c        |    7 +-
 arch/arm/mach-at91/at91sam9261.c        |    7 +-
 arch/arm/mach-at91/at91sam9263.c        |    7 +-
 arch/arm/mach-at91/at91sam9_alt_reset.S |   48 +++++
 arch/arm/mach-at91/at91sam9rl.c         |    7 +-
 arch/arm/mach-at91/board-pcontrol-g20.c |  322 +++++++++++++++++++++++++++++++
 arch/arm/mach-at91/generic.h            |    3 +
 10 files changed, 565 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/configs/pcontrol_g20_defconfig
 create mode 100644 arch/arm/mach-at91/at91sam9_alt_reset.S
 create mode 100644 arch/arm/mach-at91/board-pcontrol-g20.c

Thanks a lot, best regards,
-- 
Nicolas Ferre
