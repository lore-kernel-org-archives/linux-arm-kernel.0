From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:08:11 +1000
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.7
Message-ID: <cover.1461542941.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.7.

This pull request is based on "[GIT PULL v2] Renesas ARM Based SoC Fixes
for v4.6", tagged as renesas-fixes-for-v4.6, which I have previously sent
a pull request for.

The reason is that this series depends on c531fb27e969 ("ARM: shmobile:
timer: Fix preset_lpj leading to too short delays")


The following changes since commit c531fb27e9699eaee478ee5686a3cca5dee73602:

  ARM: shmobile: timer: Fix preset_lpj leading to too short delays (2016-04-20 08:52:55 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.7

for you to fetch changes up to a4b8c18c40704c28be62af4606cc6758c9ff3dba:

  ARM: shmobile: timer: Drop support for Cortex A8 (2016-04-20 08:55:09 +1000)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.7

Drop support for Cortex A8 in timer code

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: timer: Drop support for Cortex A8

 arch/arm/mach-shmobile/timer.c | 52 ++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)
