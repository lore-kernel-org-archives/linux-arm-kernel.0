From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 20 Feb 2014 20:54:52 +0100
Subject: [GIT PULL v2] efm32 cleanups for next
In-Reply-To: <20140219201950.GC6988@pengutronix.de>
References: <20140219201950.GC6988@pengutronix.de>
Message-ID: <20140220195452.GK6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this pull request superseeds the earlier request this mail is a reply
to. Compared to the original one I added another cleanup. Here come the
full details:

The following changes since commit 11d73c56b96b4297bd96273e9a22b7c72d13f1fa:

  Merge tag 'dropmachtimexh-v2' of git://git.pengutronix.de/git/ukl/linux into next/cleanup (2014-02-18 22:19:33 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32-next

for you to fetch changes up to f41b0482d5c1fc05234d54d58931a606ec7a97a2:

  ARM: efm32: drop selecting CLKSRC_MMIO (2014-02-20 09:56:18 +0100)

----------------------------------------------------------------
Just three simple cleanups for efm32 removing two now unused files and a
superflous select by ARCH_EFM32.

----------------------------------------------------------------
BTW, I based this on armsoc/cleanup because this is the first commit
that allows to remove efm32's <mach/timex.h> (which is the last one in
the tree).

Uwe Kleine-K?nig (3):
      ARM: efm32: drop unused file entry-macro.S
      ARM: efm32: drop unused file <mach/timex.h>
      ARM: efm32: drop selecting CLKSRC_MMIO

 arch/arm/Kconfig                               | 3 ---
 arch/arm/mach-efm32/include/mach/entry-macro.S | 4 ----
 arch/arm/mach-efm32/include/mach/timex.h       | 3 ---
 3 files changed, 10 deletions(-)
 delete mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-efm32/include/mach/timex.h
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
