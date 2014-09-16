From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 16 Sep 2014 10:57:50 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Soc Updates for v3.18
Message-ID: <cover.1410832584.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC soc updates for
v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-soc3-for-v3.18,
which you have pulled.


The following changes since commit 5923abb205e05773e0bb16c7ca4c0b41dbeec40e:

  ARM: shmobile: Initial r8a7794 SoC support (2014-09-05 17:23:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc4-for-v3.18

for you to fetch changes up to 1370078db37de2aa5e906ae2b5dbbb6ba289adb4:

  ARM: shmobile: r8a7794: Remove unnecessary #ifdef CONFIG_USE_OF (2014-09-11 09:51:16 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Soc Updates for v3.18

* r8a7794: Remove unnecessary #ifdef CONFIG_USE_OF

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: r8a7794: Remove unnecessary #ifdef CONFIG_USE_OF

 arch/arm/mach-shmobile/setup-r8a7794.c | 3 ---
 1 file changed, 3 deletions(-)
