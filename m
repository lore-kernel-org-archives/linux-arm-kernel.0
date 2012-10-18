From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 18 Oct 2012 18:18:55 +0000
Subject: [GIT PULL V2] ARM: Kirkwood: fixes for v3.7
Message-ID: <mailman.27.1350584344.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/kirkwood_fixes_for_v3.7

for you to fetch changes up to 12431634947f4c34015561104c4f8a305bfe6b48:

  ARM: kirkwood: fix buttons on lsxl boards (2012-10-18 17:07:23 +0000)

----------------------------------------------------------------
 - improve #ifdef logic to prevent linker errors with CACHE_FEROCEON_L2
 - lsxl board dts fixes

----------------------------------------------------------------
Jason Gunthorpe (1):
      ARM: Kirkwood: fix disabling CACHE_FEROCEON_L2

Michael Walle (2):
      ARM: kirkwood: fix LEDs names for lsxl boards
      ARM: kirkwood: fix buttons on lsxl boards

 arch/arm/boot/dts/kirkwood-lsxl.dtsi | 18 ++++++++++--------
 arch/arm/mach-kirkwood/board-dt.c    |  2 --
 arch/arm/mach-kirkwood/common.c      |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)
