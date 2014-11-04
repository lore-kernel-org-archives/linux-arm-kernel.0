From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:19 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Boards Cleanups for
 v3.19
Message-ID: <cover.1415059054.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC boards cleanups for v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-boards-cleanups-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit f4115f25c11790646351df243dae070a7cf80163:

  ARM: shmobile: armadillo800eva: Sort includes (2014-10-24 10:50:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-cleanups2-for-v3.19

for you to fetch changes up to 803fc9b590f74ef1066be328f2f33c2b285ca3af:

  ARM: shmobile: marzen-reference: Don't include legacy clock.h (2014-10-30 09:51:35 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Boards Cleanups for v3.19

* marzen-reference: Don't include legacy clock.h

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: marzen-reference: Don't include legacy clock.h

 arch/arm/mach-shmobile/board-marzen-reference.c | 1 -
 1 file changed, 1 deletion(-)
