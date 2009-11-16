From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Nov 2009 16:11:09 +0100
Subject: [GIT PULL] AT91 board fix for 2.6.32
Message-ID: <4B016B8D.40701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

If it can reach mainline before .32-final, maybe you 
can pull:

  git://github.com/at91linux/linux-2.6-at91.git for-linus

and receive the following change:

Nicolas Ferre (1):
      at91: at91sam9g20ek modify dual slot evaluation kit

This will align code with real at91sam9g20 Evaluation Kit from Atmel. The 
current one is not usable with the official revision of the board. This is 
why I propose it for .32-final.

Here are the stats for this commit:

 arch/arm/mach-at91/Kconfig                     |   20 +++++++++++---------
 arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c |   23 +++++++++++++++--------
 2 files changed, 26 insertions(+), 17 deletions(-)

Thanks,

-- 
Nicolas Ferre
