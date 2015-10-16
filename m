From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Oct 2015 19:39:38 +0200
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.4 (#2)
Message-ID: <87zizig1b9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for cleanup for mvebu for v4.4.

Gregory

The following changes since commit 7ee20ff0072154d326c86223fbb88d23aa152b91:

  ARM: mvebu: Use a CR_C constant instead of a hard-coded one (2015-09-29 18:01:19 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.4-2

for you to fetch changes up to ef2cdccd21513bc8fd2cf9cc2f6894d60382a4b0:

  ARM: mvebu: remove the workaround imprecise abort fault handler (2015-10-15 09:21:42 +0200)

----------------------------------------------------------------
mvebu cleanup for 4.4 (part 2)

Remove code related to Armada 375 Z1 stepping no more supported in mainline

----------------------------------------------------------------
Lucas Stach (1):
      ARM: mvebu: remove the workaround imprecise abort fault handler

 arch/arm/mach-mvebu/board-v7.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
