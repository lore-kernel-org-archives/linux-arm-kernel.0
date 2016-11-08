From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 08 Nov 2016 11:02:48 -0500
Subject: [GIT PULL] NXP LPC32xx ARM SoC DT updates for v4.10
Message-ID: <1478620968.12841.26.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx device tree updates for v4.10.

Thank you in advance.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/sylemieux/linux-lpc32xx.git tags/lpc32xx-dt-v4.10

for you to fetch changes up to 1754906fffcabdd166f6aec85eb9a3a28de531b8:

  ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2 (2016-10-25 13:29:31 -0400)

----------------------------------------------------------------
NXP LPC32xx ARM SoC device tree updates for v4.10

This includes a single functional change:
* set default parent clock for PWM1 & PWM2.

----------------------------------------------------------------
Sylvain Lemieux (1):
      ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2

arch/arm/boot/dts/lpc32xx.dtsi | 4 ++++
1 file changed, 4 insertions(+)
