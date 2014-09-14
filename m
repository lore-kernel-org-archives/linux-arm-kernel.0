From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 04:46:00 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.18
Message-ID: <20140914084600.GX21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

defconfig changes for mvebu, nothing exciting. :)

Please pull.

thx,

Jason.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.18

for you to fetch changes up to e4d223bb9bd3ac5fa87ead246f5a7e1019b1faea:

  ARM: mvebu: add gpio-fan to mvebu_v7_defconfig (2014-09-13 21:18:09 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.18

 - mvebu_v7
    - add LED class
    - add gpio-fan
    - add 'useful' options

----------------------------------------------------------------
Olof Johansson (1):
      ARM: mvebu: update v7 defconfig with useful options

Thomas Petazzoni (2):
      ARM: mvebu: add LED class support built-in in mvebu_v7_defconfig
      ARM: mvebu: add gpio-fan to mvebu_v7_defconfig

 arch/arm/configs/mvebu_v7_defconfig | 68 ++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 35 deletions(-)
