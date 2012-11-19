From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Nov 2012 17:59:04 +0100
Subject: [GIT PULL] at91: header fix for 3.8
Message-ID: <50AA6558.1060302@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A little fix that goes on top of the modification of headers made
by Jean-Christophe. Obviously, I have placed this one on top of your current
at91/header branch.

The following changes since commit 75984df05d86956541795f01e62d7dc67bc522fd:

  arm: at91: move at91rm9200 rtc header in drivers/rtc (2012-11-06 20:30:52 +0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-header

for you to fetch changes up to 2abb74eaf6e73cb42e87bdc9e9c2535ce485e614:

  atmel: move ATMEL_MAX_UART to platform_data/atmel.h (2012-11-19 17:44:54 +0100)

----------------------------------------------------------------
One fix related to UART for the "headers move" branch

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (1):
      atmel: move ATMEL_MAX_UART to platform_data/atmel.h

 arch/arm/mach-at91/include/mach/hardware.h  | 3 ---
 arch/avr32/mach-at32ap/include/mach/board.h | 1 -
 include/linux/platform_data/atmel.h         | 6 ++++++
 3 files changed, 6 insertions(+), 4 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
