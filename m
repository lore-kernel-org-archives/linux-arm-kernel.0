From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 28 Feb 2014 14:33:42 -0500
Subject: [GIT PULL] ARM: mvebu: watchdog driver changes for v3.15 (incr.
 pull #2)
Message-ID: <20140228193342.GP1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This small pull request sends a fix for warnings noticed by Olof's
autobuilder.  I don't anticipate any other changes to this branch for
this window, so I'm sending this is now.

This is an incremental pull request from tags/mvebu-watchdog-3.15 in the
mvebu/watchdog branch to tags/mvebu-watchdog-3.15-2.

Please pull.

thx,

Jason.


The following changes since commit 59416745bb8cbe32daf805f768418353168b0664:

  watchdog: orion: Enable the build on ARCH_MVEBU (2014-02-22 03:44:34 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-watchdog-3.15-2

for you to fetch changes up to edd9d3cffc90d4ed9b7b9d7d0645bd64a593c1d3:

  watchdog: orion_wdt: Use %pa to print 'phys_addr_t' (2014-02-25 19:02:54 +0000)

----------------------------------------------------------------
mvebu watchdog driver changes for v3.15 (incremental #2)

 - orion watchdog
    - remove warnings by using %pa for phys_addr_t

Depends:
 - tags/irqchip-mvebu-fixes-3.14 (already pulled by tglx)
    - both are based on v3.14-rc1

----------------------------------------------------------------
Fabio Estevam (1):
      watchdog: orion_wdt: Use %pa to print 'phys_addr_t'

 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
