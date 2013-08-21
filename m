From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Aug 2013 17:05:10 +0200
Subject: [GIT PULL] at91: device tree update for 3.12 #1
Message-ID: <1377097510-14090-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is the first pull request about DT on AT91 for 3.12.
It is based on 3.11-rc5 as I saw that the branch is coming from this tag on
your side.

Thanks, best regards,

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to 90d01929ad38259596371c78df8a9ecf37a7f815:

  ARM: at91/dt: sam9x5ek: add sound configuration (2013-08-21 13:33:44 +0200)

----------------------------------------------------------------
More DT work on AT91:
- sound support for at91sam9x5 family
- at91sam9n12: touch button, i2c and gpio-keys
- adding missing pinctrl-names to MCI on at91rm9200 and at91sam9260/9g20
- adding ARM Performance Monitor Unit (PMU) on sama5d3

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: Add PMU support for sama5d3

Jean-Christophe PLAGNIOL-VILLARD (3):
      ARM: at91: at91sam9260: add missing pinctrl-names on mmc
      ARM: at91: at91rm9200: set default mmc0 pinctrl-names
      ARM: at91/dt: add at91rm9200 PQFP package version

Richard Genoud (4):
      ARM: at91/dt: sam9x5: add SSC DMA parameters
      ARM: at91/dt: sam9x5ek: add WM8731 codec
      ARM: at91/dt: sam9x5ek: enable SSC
      ARM: at91/dt: sam9x5ek: add sound configuration

voice (3):
      ARM: at91: at91sam9n12: add pinctrl of TWI
      ARM: at91: at91sam9n12: add qt1070 support
      ARM: at91: at91sam9n12: correct pin number of gpio-key

 arch/arm/boot/dts/at91rm9200.dtsi      |  1 +
 arch/arm/boot/dts/at91rm9200_pqfp.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi     |  1 +
 arch/arm/boot/dts/at91sam9n12.dtsi     | 20 ++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts    | 18 +++++++++++++++++-
 arch/arm/boot/dts/at91sam9x5.dtsi      |  3 +++
 arch/arm/boot/dts/at91sam9x5ek.dtsi    | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi         |  5 +++++
 8 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91rm9200_pqfp.dtsi

-- 
Nicolas Ferre
