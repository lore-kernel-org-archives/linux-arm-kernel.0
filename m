From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 May 2013 12:45:47 +0200
Subject: [GIT PULL] at91: fixes for 3.10 #1
Message-ID: <1368614747-1737-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is the first AT91 fixes pull-request for 3.10-rc.

Thanks, best regards,

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to b7a8ca5173ef9aa55fa039d7c216426ff0b25a12:

  ARM: at91: rm9200 fix time support (2013-05-15 12:37:45 +0200)

----------------------------------------------------------------
An important revert on at91rm9200 platform related
to timers that prevented the platform to boot properly.
Then one pinctrl adjustments for SPI CS and a couple of
trivial typos.

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      ARM: at91/trivial: fix model name for SAM9X25-EK
      ARM: at91: rm9200 fix time support

Ludovic Desroches (1):
      ARM: at91: dts: request only spi cs-gpios used on sama5d3x cpu module

Nicolas Ferre (1):
      ARM: at91/trivial: typo in GEM compatible string

 Documentation/devicetree/bindings/net/macb.txt |  2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts            |  2 +-
 arch/arm/boot/dts/sama5d3.dtsi                 | 12 +-----------
 arch/arm/boot/dts/sama5d3xcm.dtsi              |  4 ++++
 arch/arm/mach-at91/at91rm9200_time.c           |  7 +++++--
 5 files changed, 12 insertions(+), 15 deletions(-)

-- 
Nicolas Ferre
