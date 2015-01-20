From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Jan 2015 10:26:39 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v3.19
Message-ID: <cover.1421716614.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC fixes for v3.19.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-fixes-for-v3.19,
which you have already pulled into your fixes branch.

This fixes a regression in the r8a7779 and r8a7779 SoCs due to
9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq domain.")
which was included in v3.18-rc2.


The following changes since commit b0ddb319db3d7a1943445f0de0a45c07a7f3457a:

  ARM: shmobile: sh73a0 legacy: Set .control_parent for all irqpin instances (2015-01-08 09:15:16 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes2-for-v3.19

for you to fetch changes up to f469cde20a7ee342070b4a459b6fce469a3186db:

  ARM: shmobile: r8a7779: Instantiate GIC from C board code in legacy builds (2015-01-17 09:28:41 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Fixes for v3.19

* Instantiate GIC from C board code in legacy builds on r8a7778 and r8a7779

----------------------------------------------------------------
Magnus Damm (2):
      ARM: shmobile: r8a7778: Instantiate GIC from C board code in legacy builds
      ARM: shmobile: r8a7779: Instantiate GIC from C board code in legacy builds

 arch/arm/mach-shmobile/setup-r8a7778.c | 9 ++++++++-
 arch/arm/mach-shmobile/setup-r8a7779.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)
