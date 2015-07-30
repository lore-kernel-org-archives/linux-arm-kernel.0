From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jul 2015 09:23:50 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Defconfig Updates
 for v4.3
Message-ID: <cover.1438215768.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC defconfig updates for v4.3.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig-for-v4.3,
which I have already sent a pull-request for.


The following changes since commit 821e79cb5686695f0adaef61587a184e953a937e:

  ARM: shmobile: Remove marzen_defconfig (2015-07-17 08:29:45 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v4.3

for you to fetch changes up to 4055a722d260ca30610fc52238d0aa49ff5bffa9:

  ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig (2015-07-28 09:27:00 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v4.3

* Enable fixed voltage regulator in shmobile_defconfig

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)
