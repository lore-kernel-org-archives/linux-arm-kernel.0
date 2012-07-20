From: stigge@antcom.de (Roland Stigge)
Date: Fri, 20 Jul 2012 14:07:42 +0200
Subject: [GIT PULL] ARM: LPC32xx: Core updates
Message-ID: <50094A0E.4070006@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this LPC32xx core update (branch lpc32xx/core2) builds upon the
previously provided lpc32xx/core-fixes. Basically including PWM support
(for the PWM driver from Alexandre already in the pwm tree), and
CPU ID.

Thanks,

Roland


The following changes since commit 8ba85f8bffdfbac98dac8630406f7d020103db70:

  ARM: LPC32xx: Adjust to pl08x DMA interface changes (2012-07-12 14:25:37 +0200)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core2

for you to fetch changes up to c49a18308669a7c1bd61ddd4f575a88d49b0b852:

  ARM: LPC32xx: Add PWM support (2012-07-20 14:01:51 +0200)

----------------------------------------------------------------
Alexandre Pereira da Silva (3):
      ARM: LPC32xx: Set system serial based on cpu unique id
      ARM: LPC32xx: Add PWM clock
      ARM: LPC32xx: Add PWM support

 arch/arm/Kconfig               |    1 +
 arch/arm/mach-lpc32xx/clock.c  |   14 ++++++++++++++
 arch/arm/mach-lpc32xx/common.c |   10 ++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)
