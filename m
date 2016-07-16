From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 16 Jul 2016 12:54:12 +0200
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.8 (#2)
Message-ID: <877fclsvjf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for cleanup for mvebu for v4.8.

Gregory

The following changes since commit d705c1a66e151e587271265c29844817d5108375:

  ARM: Kirkwood: fix kirkwood_pm_init() declaration/type (2016-06-16 12:01:37 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.8-2

for you to fetch changes up to ac29abf38176ec149671b01d228e0a9dc38e4e60:

  bus: mvebu-mbus: make mvebu_mbus_syscore_ops static (2016-07-11 17:59:24 +0200)

----------------------------------------------------------------
mvebu cleanup for 4.8 (part 2)

More cleanup for the mvebu mbus driver this time

----------------------------------------------------------------
Ben Dooks (2):
      bus: mvebu-mbus: fix __iomem on register pointers
      bus: mvebu-mbus: make mvebu_mbus_syscore_ops static

 drivers/bus/mvebu-mbus.c | 10 +++++-----
 include/linux/mbus.h     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)
