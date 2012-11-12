From: stigge@antcom.de (Roland Stigge)
Date: Mon, 12 Nov 2012 11:32:51 +0100
Subject: [GIT PULL] arm-soc: lpc32xx: platform updates
In-Reply-To: <509A5992.60009@antcom.de>
References: <509A5992.60009@antcom.de>
Message-ID: <50A0D053.8020602@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is a follow-up update of the previous pull request, adding only one patch
to the LPC32xx platform (Motor PWM clock by Alban Bedel).

Thanks,

Roland


The following changes since commit 91deef8069e7ffafac4467200e1d37af1b2d7c56:

  ARM: LPC32xx: Cleanup irq.c (2012-11-07 13:30:50 +0100)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core

for you to fetch changes up to 84cee34db4d34b9059f4ef66f7d1805e438cc7f3:

  ARM: LPC32xx: Add the motor PWM clock (2012-11-12 11:27:40 +0100)

----------------------------------------------------------------
Alban Bedel (1):
      ARM: LPC32xx: Add the motor PWM clock

 arch/arm/mach-lpc32xx/clock.c                 |    8 ++++++++
 arch/arm/mach-lpc32xx/include/mach/platform.h |    1 +
 2 files changed, 9 insertions(+)
