From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 30 Apr 2016 21:27:05 +0200
Subject: [GIT PULL] pxa for v4.7
Message-ID: <87a8karj7a.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

This is the pxa pull request for 4.7 cycle. I didn't include the plat-pxa/dma.c
obliteration considering it was not posted for enough time, nor the pxa25x
device-tree support. That leaves a tiny pull request, could you please consider
pulling ?

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.7

for you to fetch changes up to e4c740e23969470f779a4c67861be4f09f87d8a0:

  ARM: pxa: Remove CLK_IS_ROOT (2016-04-30 10:27:09 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.7 cycle.

This is a minor cycle with :
 - cleanup fix from Stephen on clocks (CLK_ROOT deprecated)
 - pin control activation for device-tree platforms

----------------------------------------------------------------
Robert Jarzmik (1):
      ARM: pxa: activate pinctrl for device-tree machines

Stephen Boyd (1):
      ARM: pxa: Remove CLK_IS_ROOT

 arch/arm/mach-pxa/Kconfig   | 2 ++
 arch/arm/mach-pxa/eseries.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
Robert
