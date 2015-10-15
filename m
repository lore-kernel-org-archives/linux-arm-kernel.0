From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:02 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Defconfig Updates
 for v4.4
Message-ID: <cover.1444869086.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC defconfig
updates for v4.4.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig-for-v4.4,
which I have already sent a pull-request for.


The following changes since commit 0a8b0695f4c490c349ee12956d6946576c44a419:

  ARM: multi_v7_defconfig: Remove Marzen (2015-09-14 10:12:59 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v4.4

for you to fetch changes up to fec3fb4734b4d2c33975077c250ebd4a3a9f8e34:

  ARM: multi_v7_defconfig: enable HDMI output for Renesas RCar (2015-10-13 10:42:17 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v4.4

* Enable HDMI output for Renesas RCar

----------------------------------------------------------------
Wolfram Sang (2):
      ARM: shmobile: defconfig: enable HDMI output for RCar
      ARM: multi_v7_defconfig: enable HDMI output for Renesas RCar

 arch/arm/configs/multi_v7_defconfig | 3 +++
 arch/arm/configs/shmobile_defconfig | 3 +++
 2 files changed, 6 insertions(+)
