From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:15 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Cleanup for v4.3
Message-ID: <cover.1437725206.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC cleanup for v4.3.

This pull request is based on the previous round of
such requests, tagged as renesas-cleanup-for-v4.3,
which I have already sent a pull-request for.


The following changes since commit 20834a406ee20b57c796f9911f06600b71c75788:

  ARM: shmobile: timer: r8a73a4 and r8a7790 are multi-platform only (2015-07-06 09:29:46 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v4.3

for you to fetch changes up to 151dd346a2dadaa151d5110553e3fb08774c888e:

  ARM: shmobile: apmu: silence build warnings (2015-07-14 16:35:24 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Cleanup for v4.3

* Silence APMU build warnings

----------------------------------------------------------------
Wolfram Sang (1):
      ARM: shmobile: apmu: silence build warnings

 arch/arm/mach-shmobile/platsmp-apmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
