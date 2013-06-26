From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Jun 2013 11:02:57 +0200
Subject: [GIT PULL] at91: Device Tree updates for 3.11 #3
Message-ID: <1372237377-20315-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

One more pull-request for AT91 DT patches.
It is focused on SPI on several SoCs and it particular the SPI+DMA addition on newer
SAMA5D3 and AT91SAM9N12.

Thanks, best regards,

The following changes since commit 24ce10e142e7b063c4ae4437dd3b290fbfafe052:

  ARM: at91: sam9m10g45ek add udc DT support (2013-06-15 00:15:22 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to 26e3326cc04bc3fc890a95ad6cb36359372acba5:

  ARM: at91: dt: rm9200ek: add spi support (2013-06-26 10:13:39 +0200)

----------------------------------------------------------------
- more SPI DT activation for rm9200
- SPI DMA for at91sam9n12/sama5d3
And one little fix for SPI compatibility string

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      ARM: at91: dt: rm9200: add spi support
      ARM: at91: dt: rm9200ek: add spi support

Nicolas Ferre (3):
      ARM: at91/DT: fix SPI compatibility string
      ARM: at91/DT: sama5d3: add SPI DMA client infos
      ARM: at91/DT: at91sam9n12: add SPI DMA client infos

 arch/arm/boot/dts/at91rm9200.dtsi  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek.dts | 10 ++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi |  6 ++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 10 ++++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre
