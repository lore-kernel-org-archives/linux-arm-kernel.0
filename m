From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 02 Apr 2016 14:09:14 +0200
Subject: [GIT PULL] pxa fixes for v4.6
Message-ID: <87vb40us9h.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa fixes for 4.6, made of 1 trivial
fix.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-fixes-v4.6

for you to fetch changes up to 4c35430ad18f5a034302cb90e559ede5a27f93b9:

  ARM: pxa: fix the number of DMA requestor lines (2016-03-29 20:59:18 +0200)

----------------------------------------------------------------
ARM: pxa: fixes for v4.6

There is only a single fix for dma requestor lines initial
setup, triggered by dmaengine previous fix.

----------------------------------------------------------------
Robert Jarzmik (1):
      ARM: pxa: fix the number of DMA requestor lines

 arch/arm/mach-pxa/devices.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Robert
