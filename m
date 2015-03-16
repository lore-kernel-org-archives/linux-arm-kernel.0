From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Mar 2015 21:33:07 +0100
Subject: [GIT PULL] pxa fixes for v4.0
Message-ID: <87y4mw8yyk.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Arnd, Kevin, Olof,

I'm a bit late in this window, I've been quite busy lately. Please consider
these pxa fixes for 4.0 cycle.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/fixes-for-v4.0-rc5

for you to fetch changes up to d6cf30ca716b347587b35923eda400ad2d9e8832:

  ARM: pxa: fix pxa interrupts handling in DT (2015-02-23 22:40:48 +0100)

----------------------------------------------------------------
arm: pxa: fixes for v4.0-rc5

There are only 2 fixes, one for the zeus board about the regulator changes,
where a typo prevented the zeus board from having a working can regulator,
and one regression triggered by the interrupts IRQ shift of 16 affecting all
boards.

----------------------------------------------------------------
Masanari Iida (1):
      ARM: pxa: Fix typo in zeus.c

Robert Jarzmik (1):
      ARM: pxa: fix pxa interrupts handling in DT

 arch/arm/Kconfig         |   1 +
 arch/arm/mach-pxa/irq.c  | 111 ++++++++++++++++++++---------------------------
 arch/arm/mach-pxa/zeus.c |   2 +-
 3 files changed, 50 insertions(+), 64 deletions(-)

-- 
Robert
