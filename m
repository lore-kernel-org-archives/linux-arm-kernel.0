From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:45:50 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Sh73a0 CCF Updates
 for v3.20
Message-ID: <cover.1421376276.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC sh73a0 CCF updates for v3.20.

This pull request is based on the previous round of
such requests, tagged as renesas-sh73a0-ccf-for-v3.20,
which you have already pulled.


The following changes since commit 09bd745b555c262d1e2c851777317f3adf3cf3d4:

  ARM: shmobile: sh73a0: disable legacy clock initialization (2014-12-21 17:09:25 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-ccf2-for-v3.20

for you to fetch changes up to 16bd794f9432b556ec797cbf16c5e575a18f7030:

  clk: shmobile: fix sparse NULL pointer warning (2015-01-14 13:13:24 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Sh73a0 CCF Updates for v3.20

* Fix sparse NULL pointer warning

----------------------------------------------------------------
Wei Yongjun (1):
      clk: shmobile: fix sparse NULL pointer warning

 drivers/clk/shmobile/clk-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
