From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Sep 2010 14:52:42 +0200
Subject: [GIT PULL]
Message-ID: <4C8A2A1A.1070806@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Can you please pull ARM/AT91 little fixes from:

  git://github.com/at91linux/linux-2.6-at91.git at91-fixes-for-linus

and receive the following changes:

Fabian Godehardt (1):
      AT91: SAM9G45 - add a separate clock entry for every single TC block

Nicolas Ferre (5):
      AT91: change dma resource index
      AT91: clock: peripheral clocks can have other parent than mck
      AT91: dm9000 initialization update
      AT91: at91sam9261ek board: remove warnings related to use of SPI or SD/MMC
      AT91: at91sam9261ek: remove C99 comments but keep information

 arch/arm/mach-at91/at91sam9g45.c         |   15 +++++++++++--
 arch/arm/mach-at91/at91sam9g45_devices.c |    6 ++--
 arch/arm/mach-at91/board-sam9261ek.c     |   31 ++++++++++++++++++-----------
 arch/arm/mach-at91/clock.c               |    3 +-
 4 files changed, 36 insertions(+), 19 deletions(-)

Thanks,
-- 
Nicolas Ferre
