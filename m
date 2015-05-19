From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 May 2015 16:00:09 +0200
Subject: [GIT PULL] at91: dt for 4.2 #2
Message-ID: <1432044009-26072-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Some DT updates, manly for our latest SoCs and Xplained boards.
Base on top of the at91-dt tag that you already pulled.

Thanks, best regards,

The following changes since commit 7107bb0b2836f0f9b1ffed1f5189e269ee25e5b9:

  ARM: at91/dt: drop deprecated mainck node from pmc (2015-05-11 11:24:01 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt2

for you to fetch changes up to 8d545f32bd77c10c2ab85fce4ddf1273d325d7d3:

  ARM: at91/dt: sama5d4 xplained: add regulators for v(q)mmc1 supplies (2015-05-19 15:04:55 +0200)

----------------------------------------------------------------
Second batch of DT changes for 4.2:
- sama5d4: more peripherals: usarts, uarts, spi, pioD access
- sama5d3: phy address for gmac
- change NFC register map
- regulator additions for the sd/mmc

----------------------------------------------------------------
Ben Dooks (3):
      ARM: at91/dt: sama5d3 xplained: fill in mmc1 and set it to disabled
      ARM: at91/dt: sama5d3 xplained: add mmc0 vqmmc entry
      ARM: at91/dt: sama5d3 xplained: add fixed regulator for vmmc0

Josh Wu (2):
      ARM: at91/dt: sama5d4: add usart0, usart1 dt nodes
      ARM: at91/dt: sama5: reduce the NFC command register map

Ludovic Desroches (2):
      ARM: at91/dt: sama5d4: update pinctrl ranges
      ARM: at91/dt: sama5d4 xplained: add regulators for v(q)mmc1 supplies

Nicolas Ferre (2):
      ARM: at91/dt: sama5d4 xplained: add spi1 on j14 connector
      ARM: at91/dt: sama5d3 xplained: add phy address for macb0

Suchang Ko (2):
      ARM: at91/dt: sama5d4: add uart0, uart1 dt nodes
      ARM: at91/dt: sama5d4: add spi1, spi2 dt nodes

 arch/arm/boot/dts/at91-sama5d3_xplained.dts |  27 ++++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |  25 ++++
 arch/arm/boot/dts/sama5d3.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi              | 189 +++++++++++++++++++++++++++-
 4 files changed, 240 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
