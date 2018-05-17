From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 May 2018 14:59:42 +0200
Subject: [GIT PULL] ARM: mvebu: arm for v4.18 (#1)
Message-ID: <87603m1lq9.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm for mvebu for v4.18.

As I feared, there were (trivial) merge issues due to the defconfig
update in linux-next. The best place to solve them is in your tree, so
as soon as you will pull this, I will remove from my mvebu/for-next
branch.

Gregory

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm-4.18-1

for you to fetch changes up to 95fbfe2f63d0838fed56d2f93604f205719bc51c:

  ARM: multi_v7_defconfig: Add Marvell NAND controller support (2018-05-16 19:38:34 +0200)

----------------------------------------------------------------
mvebu arm for 4.18 (part 1)

Updating multi_v7_defconfig and adding marvell NAND controller
support.

----------------------------------------------------------------
Gregory CLEMENT (2):
      ARM: multi_v7_defconfig: Update with current configuration
      ARM: multi_v7_defconfig: Add Marvell NAND controller support

 arch/arm/configs/multi_v7_defconfig | 369 +++++++++++++++---------------------
 1 file changed, 153 insertions(+), 216 deletions(-)
