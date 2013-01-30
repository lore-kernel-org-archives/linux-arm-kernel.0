From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Jan 2013 10:38:12 +0100
Subject: [GIT PULL] at91: fixes for 3.8-rc6
Message-ID: <5108EA04.80002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are two little DT fixes that will fix the use of
USART3 on at91sam9x5 platforms.


The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 7d4cfece23f535b60496d88a717a3d7bfca50187:

  ARM: at91/at91sam9x5.dtsi: fix usart3 TXD (2013-01-30 10:09:17 +0100)

----------------------------------------------------------------
Two little Device Tree fixes for USART on at91sam9x5.

----------------------------------------------------------------
Douglas Gilbert (1):
      ARM: at91/at91sam9x5.dtsi: fix usart3 TXD

Robert Nelson (1):
      ARM: at91: at91sam9x5: fix usart3 pinctrl name

 arch/arm/boot/dts/at91sam9x5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, bye,
-- 
Nicolas Ferre
