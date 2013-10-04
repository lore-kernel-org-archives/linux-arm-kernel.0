From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Oct 2013 17:19:40 +0900
Subject: [GIT PULL] Fifth Round of Renesas ARM based SoC fixes for v3.12
Message-ID: <cover.1380874512.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider this fifth Round of Renesas ARM based SoC fixes for v3.12.

This pull request is based on renesas-fixes4-for-v3.12 which you have
already pulled.


The following changes since commit 3786f86b60833f32e3eeb016fcf8c324f8147e00:

  ARM: shmobile: Remove #gpio-ranges-cells DT property (2013-09-22 21:28:18 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes5-for-v3.12

for you to fetch changes up to 40fca03cae59cfd9b87142ca327abb8a4d386908:

  ARM: shmobile: ape6evm: fix incorrect placement of __initdata tag (2013-10-01 12:53:19 +0900)

----------------------------------------------------------------
Fifth Round of Renesas ARM based SoC fixes for v3.12

* Correct incorrect placement of __initdata tag in ape6evm board code

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: shmobile: ape6evm: fix incorrect placement of __initdata tag

 arch/arm/mach-shmobile/board-ape6evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
