From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 11 Jul 2018 22:24:26 +0200
Subject: [GIT PULL] pxa fixes for v4.18
Message-ID: <871sc9ed1h.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa fixes for 4.18.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-fixes-4.18

for you to fetch changes up to 0c1049dcb4ceec640d8bd797335bcbebdcab44d2:

  ARM: pxa: irq: fix handling of ICMR registers in suspend/resume (2018-07-07 13:25:15 +0200)

----------------------------------------------------------------
This is the fixes set for v4.18 cycle.

This is a fix for suspending all pxa3xx platforms, where high
number interrupts are not reenabled.

----------------------------------------------------------------
Daniel Mack (1):
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

 arch/arm/mach-pxa/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Robert
