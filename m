From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 17 Jul 2015 23:42:26 +0200
Subject: [GIT PULL] pxa fixes for v4.2
Message-ID: <87vbdih35p.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa fixes for 4.2.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-fixes-v4.2-rc2

for you to fetch changes up to a927ef895e288e79f1bfed221f27d7bfa37e907f:

  ARM: pxa: fix dm9000 platform data regression (2015-07-16 22:43:59 +0200)

----------------------------------------------------------------
ARM: pxa: fixes for v4.2-rc2

This single fix reenables ethernet cards for several pxa boards,
broken by regulator addition to dm9000 driver.

----------------------------------------------------------------
Robert Jarzmik (1):
      ARM: pxa: fix dm9000 platform data regression

 arch/arm/mach-pxa/capc7117.c       | 3 +++
 arch/arm/mach-pxa/cm-x2xx.c        | 3 +++
 arch/arm/mach-pxa/cm-x300.c        | 2 ++
 arch/arm/mach-pxa/colibri-pxa270.c | 3 +++
 arch/arm/mach-pxa/em-x270.c        | 2 ++
 arch/arm/mach-pxa/icontrol.c       | 3 +++
 arch/arm/mach-pxa/trizeps4.c       | 3 +++
 arch/arm/mach-pxa/vpac270.c        | 3 +++
 arch/arm/mach-pxa/zeus.c           | 2 ++
 9 files changed, 24 insertions(+)

Cheers

-- 
Robert
