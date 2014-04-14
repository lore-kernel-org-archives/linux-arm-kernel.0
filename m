From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 Apr 2014 13:02:44 +0900
Subject: [GIT PULL] Fifth Round of Renesas ARM Based SoC DT Updates for v3.15
Message-ID: <cover.1397448066.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this fifth round of Renesas ARM based SoC DT updates for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-dt4-for-v3.15,
which I have already sent a pull-request for.

I am sending this pull request (long) after the release of v3.14-rc6
as it contains a single bug-fix.


The following changes since commit 2c60a7df72711fb8b4be1e6aa651ab166a8931bc:

  ARM: shmobile: Add SDHI devices for Koelsch DTS (2014-02-26 15:11:41 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt5-for-v3.15

for you to fetch changes up to b08eed0c4d7d70eae2f4f1ff518cc33643722a07:

  ARM: shmobile: lager: correct renesas,gpios to renesas,groups in sd[02] pfc (2014-04-08 09:38:51 +0900)

----------------------------------------------------------------
Fifth Round of Renesas ARM Based SoC DT Updates for v3.15

Correct renesas,groups in SDHI nodes of for r8a7790 (R-Car H2) based
Lager board.

----------------------------------------------------------------
Rob Taylor (1):
      ARM: shmobile: lager: correct renesas,gpios to renesas,groups in sd[02] pfc

 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
