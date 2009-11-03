From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 03 Nov 2009 19:11:14 +0100
Subject: [GIT PULL] AT91/AVR32 some common macros
Message-ID: <4AF07242.3070803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

If it not bother you too much to pull such a tiny and 
trivial piece of code, can you please pull:

  git://github.com/at91linux/linux-2.6-at91.git for-linus

I directly sent this to you as it require two arch subsystems to 
synchronize. As I have some .32 fixes that are waiting for those 
lines to be merged to go upstream, I thought it was worth a try.

You can receive the following changes:

Nicolas Ferre (2):
      avr32: add two new at91 to cpu.h definition
      at91: at91sam9g45 family: identify several chip versions

 arch/arm/mach-at91/include/mach/cpu.h     |    9 +++++++++
 arch/avr32/mach-at32ap/include/mach/cpu.h |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)



-- 
Nicolas Ferre
