From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:16 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clock Updates for v3.17
Message-ID: <cover.1403487071.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this Renesas ARM based SoC clock update for v3.17.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-clock-for-v3.17

for you to fetch changes up to edc8fb1d6ebdfc4efa009073586d3567c3368475:

  ARM: shmobile: Fix device node reference leakage in shmobile_init_delay (2014-06-16 19:52:00 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clock Updates for v3.17

* Fix device node reference leakage in shmobile_init_delay

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: Fix device node reference leakage in shmobile_init_delay

 arch/arm/mach-shmobile/timer.c | 50 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)
