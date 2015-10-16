From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Fri, 16 Oct 2015 09:28:42 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.4, part 2
Message-ID: <1445005724-32349-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling this patch for v4.4.

Thanks,
Dinh

The following changes since commit 78cd6a9d8e154fe2ac5d2b912519e27545cfd13b:

  arm64: dts: Add base stratix 10 dtsi (2015-10-06 04:42:38 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.4_part_2

for you to fetch changes up to ebb251030bf25b27b05f0e4204e27b85c5664364:

  ARM: socfpga: dts: add fpga manager (2015-10-15 22:28:08 -0500)

----------------------------------------------------------------
SoCFPGA DTS update for v4.4, part 2
- Add the FPGA manager node

----------------------------------------------------------------
Alan Tull (1):
      ARM: socfpga: dts: add fpga manager

 arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
