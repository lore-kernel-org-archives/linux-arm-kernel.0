From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Sep 2013 15:23:21 +0900
Subject: [GIT PULL] Third Round of Renesas ARM based SoC fixes for v3.12
Message-ID: <cover.1378362045.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this third round of Renesas ARM based SoC DT fixes for v3.12.

This pull request is based on renesas-fixes2-for-v3.12 which
you have already pulled.


The following changes since commit ab40900b70dc31a64f23b1b4dbb0917afb039775:

  ARM: shmobile: armadillo800eva-reference: fix compiler warning (2013-07-23 10:35:33 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes3-for-v3.12

for you to fetch changes up to 7658ea2fb57831c6836ffcfb20bcb84f3ff55dfb:

  ARM: shmobile: r8a7779: Update early timer initialisation order (2013-08-30 09:31:39 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM based SoC fixes for v3.12

* Update early timer initialisation order of r8a7779 SoC

  This resolves a regression introduced by
  a894fcc2d01a89e6fe3da0845a4d80a5312e1124 ("ARM: smp_twd: Divorce smp_twd
  from local timer API").
  This problem was introduced in v3.10-rc2.

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: r8a7779: Update early timer initialisation order

 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
