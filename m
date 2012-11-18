From: stigge@antcom.de (Roland Stigge)
Date: Sun, 18 Nov 2012 16:27:00 +0100
Subject: [GIT PULL] arm-soc: lpc32xx: dts update
Message-ID: <50A8FE44.3030401@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this pull request includes the dts updates for lpc32xx for 3.7. (Hoping that
the signed tag works for you.)

Thanks in advance,

Roland


The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git tags/lpc32xx-dts-for-3.7

for you to fetch changes up to b7d41c937ed742b0995e4824ed2d0be085f80c1d:

  ARM: LPC32xx: Add the motor PWM to base dts file (2012-11-14 15:41:18 +0100)

----------------------------------------------------------------
DTS updates for the LPC32xx Soc for 3.7

This time, only one patch: Adding the motor PWM to lpc32xx.dtsi

----------------------------------------------------------------
Alban Bedel (1):
      ARM: LPC32xx: Add the motor PWM to base dts file

 arch/arm/boot/dts/lpc32xx.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)
