From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 1 Jul 2011 08:54:11 +0200
Subject: AT91: Fix pull requset
Message-ID: <20110701065411.GD14408@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Linus, Russell, Arnd

	I do not known who can take this pull request

	But this is some fix for at91 for the 3.0

The following changes since commit 5220cc9382e11ca955ce946ee6a5bac577bb14ff:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block (2011-06-24 08:42:35 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-2.6-at91.git at91-next

Jean-Christophe PLAGNIOL-VILLARD (3):
      at91: fix at91_set_serial_console: use platform device id
      atmel_serial: fix internal port num
      at91: fix udc, ehci and mmc clock device name for cap9/9g45/9rl

Joachim Eastwood (1):
      at91: Use "pclk" as con_id on at91cap9 and at91rm9200

 arch/arm/mach-at91/at91cap9.c            |    8 ++++----
 arch/arm/mach-at91/at91cap9_devices.c    |    2 +-
 arch/arm/mach-at91/at91rm9200.c          |    6 +++---
 arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9g45.c         |   10 +++++-----
 arch/arm/mach-at91/at91sam9g45_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9rl.c          |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
 drivers/tty/serial/atmel_serial.c        |    3 ++-
 12 files changed, 23 insertions(+), 22 deletions(-)

Best Regards,
J.
