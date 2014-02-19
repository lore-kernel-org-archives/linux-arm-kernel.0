From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Feb 2014 21:19:50 +0100
Subject: [GIT PULL] efm32 cleanups for next
Message-ID: <20140219201950.GC6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following changes since commit 11d73c56b96b4297bd96273e9a22b7c72d13f1fa:

  Merge tag 'dropmachtimexh-v2' of git://git.pengutronix.de/git/ukl/linux into next/cleanup (2014-02-18 22:19:33 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32-next

for you to fetch changes up to c72b549182841e3ce3e4849cd7c9b178615f8224:

  ARM: efm32: drop unused file <mach/timex.h> (2014-02-19 11:50:52 +0100)

----------------------------------------------------------------
Just two simple cleanups for efm32 removing two now unused files.

----------------------------------------------------------------
Uwe Kleine-K?nig (2):
      ARM: efm32: drop unused file entry-macro.S
      ARM: efm32: drop unused file <mach/timex.h>

These changes are trivial enough that I don't expect any opposition, 
so they come at once in the form of a pull request. I will send the two
patches as reply to this mail anyhow.

Best regards
Uwe

 arch/arm/mach-efm32/include/mach/entry-macro.S | 4 ----
 arch/arm/mach-efm32/include/mach/timex.h       | 3 ---
 2 files changed, 7 deletions(-)
 delete mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-efm32/include/mach/timex.h

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
