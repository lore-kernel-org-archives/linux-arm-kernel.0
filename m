From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 11:49:22 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Defconfig Updates
 for v4.14
Message-ID: <cover.1502960320.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC defconfig updates for v4.14.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig-for-v4.14,
which you have already pulled.


The following changes since commit 52078ca712cd933844721aaa700b3bd85234841f:

  ARM: multi_v7_defconfig: Enable DMA for Renesas serial ports (2017-07-27 16:06:23 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v4.14

for you to fetch changes up to 0736aad1290d61bc3668f20253e1e1997ad8b3c1:

  ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig (2017-08-09 11:03:26 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v4.14

* Enable BQ32000 rtc in shmobile_defconfig

  Biju Das says "The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).  To
  increase hardware support enable the driver in the shmobile_defconfig
  multiplatform configuration."

----------------------------------------------------------------
Biju Das (1):
      ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)
