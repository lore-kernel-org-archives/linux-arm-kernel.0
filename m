From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Mar 2014 21:57:18 +0100
Subject: [GIT PULL] ARM: efm32: 2nd batch for 3.15-rc1
Message-ID: <20140314205718.GA31517@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following changes since commit d5d5ce952a66c32abf36a6fdf2a1ba6cb8da9b93:

  ARM: efm32: drop unused file <mach/timex.h> (2014-02-24 10:07:27 +0100)

that you already pulled from me are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32-next

for you to fetch changes up to 35c3a9c8074efa2e763ef1da31e6a9e419884a81:

  ARM: efm32: properly namespace i2c location property (2014-03-14 16:04:30 +0100)

----------------------------------------------------------------
Two more dt related efm32 fixes

----------------------------------------------------------------
Uwe Kleine-K?nig (2):
      ARM: efm32: fix unit address part in USART2 device nodes' names
      ARM: efm32: properly namespace i2c location property

 arch/arm/boot/dts/efm32gg-dk3750.dts | 2 +-
 arch/arm/boot/dts/efm32gg.dtsi       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
