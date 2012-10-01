From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 30 Sep 2012 21:49:05 -0400
Subject: [GIT PULL] ARM: Kirkwood: build fix CACHE_FEROCEON_L2
Message-ID: <20121001014905.GJ17765@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Depends:
 - Based on arm-soc/late/kirkwood

Adds:
 - Better #ifdef logic for CACHE_FEROCEON_L2 to prevent linker errors

The following changes since commit 46f2007c1efadfa4071c17e75f140c47f09293de:

  ARM: mvebu: fix build breaks from multi-platform conversion (2012-09-28 22:27:07 +0200)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/cache-build-fix

Jason Gunthorpe (1):
      Build failure CONFIG_ARCH_KIRKWOOD_DT relies on CACHE_FEROCEON_L2

 arch/arm/mach-kirkwood/board-dt.c |    2 --
 arch/arm/mach-kirkwood/common.c   |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)
