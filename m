From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 16:29:31 -0500
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.14
Message-ID: <20131201212931.GZ2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Last small one for today.  You can hold off on this one as well if you
like, but I also don't forsee adding a bunch to this branch either.

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.14

for you to fetch changes up to 9ec1acb88698d3b5f181fe8621d259c59b392e49:

  ARM: kirkwood: enable HIGHMEM in defconfig (2013-11-23 17:17:13 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.14

 - mvebu: add GPIO LEDs
 - kirkwood: enable HIGHMEM

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: config: Add GPIO connected LEDs support to defconfig

Thomas Petazzoni (1):
      ARM: kirkwood: enable HIGHMEM in defconfig

 arch/arm/configs/kirkwood_defconfig | 1 +
 arch/arm/configs/mvebu_defconfig    | 1 +
 2 files changed, 2 insertions(+)
