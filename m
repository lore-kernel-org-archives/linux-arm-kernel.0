From: stigge@antcom.de (Roland Stigge)
Date: Tue, 13 Mar 2012 23:21:30 +0100
Subject: [GIT PULL] LPC32xx: Ethernet support
Message-ID: <4F5FC86A.70501@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

now that David Miller has accepted the LPC32xx Ethernet patches into
net-next, I'm providing the respective LPC32xx platform code as described
below.

It's on top of v3.3-rc5, the already existing LPC32xx patches in arm-soc
and the USB support patch. So please first pull the USB patch.

Thanks in advance,

Roland



The following changes since commit 48a5dedfa78899dad50b3b4ae30f07e27e6591ab:

  ARM: LPC32xx: USB Support (2012-03-13 21:15:50 +0100)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/mach-lpc32xx-eth

for you to fetch changes up to c20b909be9ba27173294a52d08cab293ec030a2c:

  ARM: LPC32xx: Ethernet support (2012-03-13 21:23:07 +0100)

----------------------------------------------------------------
Roland Stigge (1):
      ARM: LPC32xx: Ethernet support

 arch/arm/mach-lpc32xx/Kconfig              |   25 +++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/clock.c              |    2 +-
 arch/arm/mach-lpc32xx/common.c             |   21 +++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h             |    4 ++--
 arch/arm/mach-lpc32xx/include/mach/board.h |   24 ++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/irq.c                |    4 ++++
 arch/arm/mach-lpc32xx/phy3250.c            |    2 ++
 7 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/board.h
