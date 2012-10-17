From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Oct 2012 19:25:43 +0000
Subject: [GIT PULL 3/3] ARM: Kirkwood: fix for v3.7
In-Reply-To: <pull-1350501943-114231>
Message-ID: <mailman.24.1350501966.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/kirkwood_cache_build_fix_for_v3.7

for you to fetch changes up to f7d87d2726f823dc4a0d4900ac06446e4e485fdb:

  Build failure CONFIG_ARCH_KIRKWOOD_DT relies on CACHE_FEROCEON_L2 (2012-10-17 17:56:37 +0000)

----------------------------------------------------------------
Depends:
 - Based on v3.7-rc1

Adds:
 - Better #ifdef logic for CACHE_FEROCEON_L2 to prevent linker errors

----------------------------------------------------------------
Jason Gunthorpe (1):
      Build failure CONFIG_ARCH_KIRKWOOD_DT relies on CACHE_FEROCEON_L2

 arch/arm/mach-kirkwood/board-dt.c | 2 --
 arch/arm/mach-kirkwood/common.c   | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)
