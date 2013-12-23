From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:37 +0900
Subject: [GIT PULL] Second Round of Renesas ARM based SoC cleanups for v3.14
Message-ID: <cover.1387762178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC cleanups for v3.14.

It is based on the first round of cleanups, tagged as
renesas-cleanup-for-v3.14, which you have already pulled.


The following changes since commit 8af3f18b7b42e32387b54d2e2f8300589b0198e9:

  ARM: shmobile: sh7372: tidyup clock table order (2013-11-24 15:14:32 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v3.14

for you to fetch changes up to 2eb7a8146f5ab5be7cde42438e32461f313d0d0b:

  ARM: shmobile: remove unnecessary platform_device as header cleanup (2013-12-12 21:52:43 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC cleanups for v3.14

* r8a7779 SoC (R-Car H1)
  - Remove unnecessary platform device from header file

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: remove unnecessary platform_device as header cleanup

 arch/arm/mach-shmobile/include/mach/r8a7779.h | 2 --
 1 file changed, 2 deletions(-)
