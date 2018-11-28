From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 28 Nov 2018 09:44:02 -0600
Subject: [GIT PULL 1/2] ARM: socfpga: updates for v4.20
Message-ID: <20181128154403.12872-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA updates for v5.0.

Thanks,
Dinh

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v5.0

for you to fetch changes up to fbc125afdc5048cb027002147a0e0def7c18573a:

  ARM: socfpga: Turn on ARM errata for L2 cache (2018-11-28 09:23:11 -0600)

----------------------------------------------------------------
SoCFPGA updates for v5.0
- Split Kconfig options for debug UART on Cyclone5
- Remove unused functions from socfpga platform code
- Turn on ARM and PL310 errata for SOCFPGA ARMv7 platform

----------------------------------------------------------------
Cl?ment P?ron (2):
      ARM: debug: enable UART1 for socfpga Cyclone5
      ARM: socfpga: Clean unused functions

Dinh Nguyen (1):
      ARM: socfpga: Turn on ARM errata for L2 cache

 arch/arm/Kconfig.debug          | 23 ++++++++++++++++-------
 arch/arm/mach-socfpga/Kconfig   |  7 +++++++
 arch/arm/mach-socfpga/core.h    |  2 --
 arch/arm/mach-socfpga/socfpga.c |  2 +-
 4 files changed, 24 insertions(+), 10 deletions(-)
