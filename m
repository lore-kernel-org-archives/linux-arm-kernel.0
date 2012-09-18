From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Sep 2012 13:46:58 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fix for v3.6 #3
Message-ID: <1347943619-27649-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following fix for the KZM-A9-GT board for 3.6.

----------------------------------------------------------------
The following changes since commit 28e515878f8896b33c325ff9767cb0237210fb4c:

  ARM: shmobile: armadillo800eva: enable rw rootfs mount (2012-09-03 17:31:34 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git fixes

for you to fetch changes up to a704835d6a7a8254067a1be60d614cd5c0c73e44:

  ARM: shmobile: kzm9g: bugfix: correct mmcif interrupt settings (2012-09-18 11:19:44 +0900)

----------------------------------------------------------------
Tetsuyuki Kobayashi (1):
      ARM: shmobile: kzm9g: bugfix: correct mmcif interrupt settings

 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
