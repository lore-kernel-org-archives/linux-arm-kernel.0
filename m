From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 20 Feb 2014 21:09:40 +0100
Subject: [GIT PULL] v7m patches for next
Message-ID: <20140220200940.GL6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/v7m-next

for you to fetch changes up to f0d7515372ff0ea53fd66099533d3c8e0464cbbf:

  ARM: v7m: add trivial suspend support (2014-02-03 17:30:45 +0100)

----------------------------------------------------------------
Two bugfixes and trivial suspend support for v7m.

----------------------------------------------------------------
Given that the bugfixes are only relevant when an oops is in progress
and admitting that there are not so many v7m users I don't see an urge
to include the bugfixes in 3.14 and so target 3.15-rc1 for this pull
request.

Uwe Kleine-K?nig (3):
      ARM: make isa_mode macro more robust and fix for v7-M
      ARM: show_regs: on v7-M there are no FIQs, different processor modes, ...
      ARM: v7m: add trivial suspend support

 arch/arm/Kconfig              | 2 +-
 arch/arm/include/asm/ptrace.h | 8 ++++++--
 arch/arm/kernel/process.c     | 9 +++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
