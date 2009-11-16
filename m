From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Nov 2009 16:30:51 +0100
Subject: [GIT PULL] AT91 Kconfig rework
Message-ID: <4B01702B.4080107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This is AT91 Kconfig rework for next merge window. After 
discussing it on the mailing-list and Ack by Andrew Victor, I 
send you this patchset. You can pull it from:

  git://github.com/at91linux/linux-2.6-at91.git for-rmk

And you will receive:

Jean-Christophe PLAGNIOL-VILLARD (2):
      at91: remove not needed depends on
      at91: Kconfig simplification

Nicolas Ferre (2):
      at91: at91sam9g20ek modify dual slot evaluation kit
      atmel_lcdfb Kconfig: remove long dependency line

 arch/arm/mach-at91/Kconfig                     |  107 ++++++++++++++----------
 arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c |   23 ++++--
 arch/avr32/Kconfig                             |    1 +
 drivers/video/Kconfig                          |    5 +-
 4 files changed, 83 insertions(+), 53 deletions(-)

The patch
"at91: at91sam9g20ek modify dual slot evaluation kit"
is also already sent directly to Linus for .32-final (not 
sure it can reach). Anyway, I guess that git can handle 
that...

Thanks. Best regards,
-- 
Nicolas Ferre
