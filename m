From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 15 Jun 2017 08:27:06 +0200
Subject: [GIT PULL] pxa for v4.13
Message-ID: <87mv99u5ol.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa 4.13 cycle, nothing very fancy either
this cycle.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.13

for you to fetch changes up to ce3de60ff92ba5e4d65f1c1ce07460795e3a6157:

  ARM: pxa: Delete an error message for a failed memory allocation in pxa3xx_u2d_probe() (2017-06-14 08:32:21 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.13 cycle.

This cycle is a minor fixes one, with :
 - Coccinelle found improvements
 - magician getting touchscreen driver support.

----------------------------------------------------------------
Markus Elfring (3):
      ARM: pxa: Delete an error message for a failed memory allocation in pxa_pm_init()
      ARM: pxa: Improve a size determination in pxa3xx_u2d_probe()
      ARM: pxa: Delete an error message for a failed memory allocation in pxa3xx_u2d_probe()

Petr Cvek (1):
      ARM: pxa: magician: Add support for ADS7846 touchscreen

 arch/arm/mach-pxa/include/mach/magician.h |  1 +
 arch/arm/mach-pxa/magician.c              | 84 ++++++++++++++++++++++++++++++-
 arch/arm/mach-pxa/pm.c                    |  4 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c           |  6 +--
 4 files changed, 87 insertions(+), 8 deletions(-)

-- 
Robert
