From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 17:30:56 +0100
Subject: [GIT PULL] LPC32xx fixes for v3.3-rc4
Message-ID: <4F490CC0.5050303@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

the fixes for LPC32xx that I just posted as patches are also available as a
git branch to pull from as described below.

Thanks in advance,

Roland



The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx-fixes

for you to fetch changes up to 3eddb16b7b275162c62f67bb75cc6bbe0ef8c075:

  ARM: LPC32xx: serial.c: Fixed loop limit (2012-02-25 16:32:44 +0100)

----------------------------------------------------------------
Roland Stigge (6):
      ARM: LPC32xx: Fix irq on GPI_28
      ARM: LPC32xx: Fix missing and bad LPC32XX macros
      ARM: LPC32xx: Fix interrupt controller init
      ARM: LPC32xx: irq.c: Clear latched event
      ARM: LPC32xx: serial.c: HW bug workaround
      ARM: LPC32xx: serial.c: Fixed loop limit

 arch/arm/mach-lpc32xx/include/mach/irqs.h     |    2 +-
 arch/arm/mach-lpc32xx/include/mach/platform.h |   51 +++++++++++++------------
 arch/arm/mach-lpc32xx/irq.c                   |   25 ++++++++++--
 arch/arm/mach-lpc32xx/pm.c                    |    2 +-
 arch/arm/mach-lpc32xx/serial.c                |   20 +++++++++-
 arch/arm/mach-lpc32xx/timer.c                 |   48 ++++++++++++------------
 6 files changed, 92 insertions(+), 56 deletions(-)
