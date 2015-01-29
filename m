From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Jan 2015 15:43:53 +0100
Subject: [GIT PULL] Zynq SoC changes for 3.20
Message-ID: <1f0d53f4aa6f40659cd299540eaed31c@BN1AFFO11FD019.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these 4 patches to your tree.

Thanks,
Michal

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-3.20

for you to fetch changes up to 3329659df0300d1d0aa22f5e7063f83a88ef92aa:

  ARM: zynq: Simplify SLCR initialization (2015-01-29 15:38:17 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq SoC patches for v3.20

- Enable pincontrol
- Simplified SLCR initialization
- Setup default ARCH_NR_GPIO

----------------------------------------------------------------
Michal Simek (2):
      ARM: zynq: Setup default gpio number for Xilinx Zynq
      ARM: zynq: Simplify SLCR initialization

Moritz Fischer (1):
      ARM: zynq: PM: Fixed simple typo.

Soren Brinkmann (1):
      ARM: zynq: Enable pinctrl

 arch/arm/Kconfig            |  2 +-
 arch/arm/mach-zynq/Kconfig  |  2 ++
 arch/arm/mach-zynq/common.c |  2 --
 arch/arm/mach-zynq/pm.c     |  2 +-
 arch/arm/mach-zynq/slcr.c   | 35 +++++++----------------------------
 5 files changed, 11 insertions(+), 32 deletions(-)
