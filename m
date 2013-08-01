From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:27:15 +0900
Subject: [GIT] Second Round of Renesas ARM based SoC fixes for v3.12
Message-ID: <cover.1375345067.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC fixes for v3.12.

It is based on the first round of Renesas ARM based SoC fixes for v3.12,
/renesas-fixes-for-v3.12, which I have already send a pull-request for.

The following changes since commit 93d8a6fbe69a629a7bb37bb546699a5c49963dc5:

  ARM: shmobile: r8a7740: Fix TPU clock name (2013-07-19 11:12:35 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v3.12

for you to fetch changes up to ab40900b70dc31a64f23b1b4dbb0917afb039775:

  ARM: shmobile: armadillo800eva-reference: fix compiler warning (2013-07-23 10:35:33 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC fixes for v3.12

* Fix compiler warning in armadillo800eva board code

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: armadillo800eva-reference: fix compiler warning

 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
