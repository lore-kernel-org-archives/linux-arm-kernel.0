From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 2 Dec 2013 15:52:19 -0500
Subject: [GIT PULL for-next] ARM: mm: Switch ARM port to NO_BOOTMEM for 3.14
Message-ID: <1386017539-10295-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Here is the pull request for-next so that the series gets wider testing
to catch any regression early in the cycle.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_3.14/arm-no-bootmem

for you to fetch changes up to 84f452b1e8fc73ac0e31254c66e3e2260ce5263d:

  ARM: mm: Remove bootmem code and switch to NO_BOOTMEM (2013-11-23 17:58:35 -0500)

----------------------------------------------------------------

Grygorii Strashko (1):
  ARM: mm: Don't allow resizing of memblock data until "low" memory is
    not mapped

Santosh Shilimkar (2):
  ARM: mm: Fix max_mapnr with recent max*pfn updates
  ARM: mm: Remove bootmem code and switch to NO_BOOTMEM

 arch/arm/Kconfig        |    1 +
 arch/arm/kernel/setup.c |    2 +-
 arch/arm/mm/init.c      |   62 +++--------------------------------------------
 3 files changed, 6 insertions(+), 59 deletions(-)

-- 
1.7.9.5
