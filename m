From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Fri, 10 Jul 2015 10:48:17 -0500
Subject: [GIT PULL] SoCFPGA fixes for v4.2-rc1
Message-ID: <1436543297-3254-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

Please pull in these fixes for v4.2-rc1.

Thanks,

Dinh

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_fixes_for_v4.2-rc1

for you to fetch changes up to 93abc72bc7901cfc61a2871da7a565c9fdb26108:

  ARM: socfpga: dts: Fix entries order (2015-07-07 08:58:02 -0500)

----------------------------------------------------------------
SoCFPGA fixes against v4.2-rc1
- Update compatible "adxl345x" compatible string
- Alphabetize the DTS nodes for the C5 sockit board file

----------------------------------------------------------------
Walter Lozano (2):
      ARM: socfpga: dts: Fix adxl34x formating and compatible string
      ARM: socfpga: dts: Fix entries order

 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)
