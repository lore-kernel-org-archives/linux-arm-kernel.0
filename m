From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Jun 2014 08:52:36 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.17
Message-ID: <20140627125236.GG23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's the cooresponding defconfig changes for the kirkwood board
migration.  The setup file needs to be enabled in multi_v5 and
mvebu_v5.

Please pull.

thx,

Jason.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.17

for you to fetch changes up to 5658d58545388850c77a070fb3b882ddd958eb88:

  ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2 (2014-06-20 20:50:23 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.17

 - mvebu (v5)
    - add LaCie 2Big and 5Big Network v2

 - multi (v5)
    - add LaCie 2Big and 5Big Network v2

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: mvebu: Add LaCie 2Big and 5Big Network v2
      ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2

 arch/arm/configs/multi_v5_defconfig | 2 ++
 arch/arm/configs/mvebu_v5_defconfig | 2 ++
 2 files changed, 4 insertions(+)
