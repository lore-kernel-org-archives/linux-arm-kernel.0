From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Sep 2014 11:03:19 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clk Updates for v3.18
Message-ID: <cover.1409536884.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC clk updates for v3.18.


I am taking this change through my tree with Mike's Ack
as it seems to be a smooth way to handle things.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clk-for-v3.18

for you to fetch changes up to 8de078f189da45453d2ed2a04288e329cc169731:

  clk: shmobile: Add r8a7794 support (2014-08-27 08:40:54 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clk Updates for v3.18

* Add r8a7794 support

----------------------------------------------------------------
Hisashi Nakamura (1):
      clk: shmobile: Add r8a7794 support

 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)
