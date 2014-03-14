From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 14 Mar 2014 16:53:35 +0100
Subject: [PATCH 0/2] two more efm32 fixes
Message-ID: <1394812417-22391-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I intend to add these two patches on top of the efm32-next tag that is
already in arm-soc. I already asked on irc, but in case the question
goes missing there: Do you prefer incremental pull requests or should I
recreate a new one on top of the old such that you only have one merge
for efm32 in the history and still have the complete summary from the
tag?

Uwe Kleine-K?nig (2):
  ARM: efm32: fix unit address part in USART2 device nodes' names
  ARM: efm32: properly namespace i2c location property

 arch/arm/boot/dts/efm32gg-dk3750.dts | 2 +-
 arch/arm/boot/dts/efm32gg.dtsi       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.0
