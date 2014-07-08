From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Jul 2014 11:34:14 +0200
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Updates for v3.17
Message-ID: <cover.1404811926.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-soc2-for-v3.17,
which I have already sent a pull-request for.


The following changes since commit bfe4cfa8ae21628267f2b879b4396ee17ea4fd3a:

  ARM: shmobile: Allow r8a7791 to build non-SMP APMU code (2014-06-26 16:01:34 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc3-for-v3.17

for you to fetch changes up to d358c99838f3cf63ad7536124be4318cc84b11fa:

  ARM: shmobile: fix shmobile_smp_apmu_suspend_init build failure for !SUSPEND (2014-07-06 16:31:56 +0200)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Updates for v3.17

* Correct build failure in APMU code in the case of !SUSPEND

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: fix shmobile_smp_apmu_suspend_init build failure for !SUSPEND

 arch/arm/mach-shmobile/platsmp-apmu.c | 2 --
 1 file changed, 2 deletions(-)
