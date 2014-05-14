From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 14 May 2014 11:19:22 +0200
Subject: [GIT PULL] at91: DT for 3.16 #2
Message-ID: <1400059162-630-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

More DT material for AT91. Some fixes that apply on what was merged for 3.15
but that are not very critical.
The other patches are feature additions to old or very recent product/board:
at91sam9261 or sama5d3 Xplained.

Thanks, best regards,

The following changes since commit 27a96a0364787d2b41d2a72d08143d95263e1b07:

  ARM: at91: sama5d3: clock for ssc from rk pin (2014-04-18 22:43:44 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt2

for you to fetch changes up to a93f9c88b7701d1c4c3b22d39d64a408f000a6ef:

  ARM: at91/dt: at91-sama5d3_xplained: add the regulator device node (2014-05-12 16:48:54 +0200)

----------------------------------------------------------------
3.16: second DT series:
- at91sam9rl and at91sam9261 fixes about PLL ranges
- at91sam9261 more comprehensive support for SSC
- sama5d3 Xplained: addition of pull-ups, PWM and PMIC (regulator)

----------------------------------------------------------------
Alexandre Belloni (3):
      ARM: at91/dt: sam9261: Fix PLL output ranges and other clocks divisors
      ARM: at91/dt: sam9261: Add ssc2, SSC clocks and pcks
      ARM: at91/dt: sam9rl: Fix PLL output range and mck divisors

Nicolas Ferre (3):
      ARM: at91: add pull-up to i2c[02] on SAMA5D3 Xplained
      ARM: at91: add PWM pinctrl to SAMA5D3
      ARM: at91: add 2 PWM outputs to SAMA5D3 Xplained

Wenyou Yang (1):
      ARM: at91/dt: at91-sama5d3_xplained: add the regulator device node

 arch/arm/boot/dts/at91-sama5d3_xplained.dts |  62 +++++++++++++++
 arch/arm/boot/dts/at91sam9261.dtsi          | 114 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/at91sam9rl.dtsi           |   7 +-
 arch/arm/boot/dts/sama5d3.dtsi              |  78 +++++++++++++++++++
 4 files changed, 253 insertions(+), 8 deletions(-)

-- 
Nicolas Ferre
