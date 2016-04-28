From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 28 Apr 2016 09:44:04 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.7, part 2
Message-ID: <1461854644-3638-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this patch for v4.7.

Thanks,
Dinh

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.7_part_2

for you to fetch changes up to 6b126245907a77642efe738f81837dc58e3a5d28:

  ARM: dts: socfpga: Add samtec VIN|ING board (2016-04-22 10:09:02 -0500)

----------------------------------------------------------------
SoCFPGA DTS update for v4.7, part 2
- Add samtec VIN|ING board

----------------------------------------------------------------
Marek Vasut (1):
      ARM: dts: socfpga: Add samtec VIN|ING board

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 310 +++++++++++++++++++++
 2 files changed, 311 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
