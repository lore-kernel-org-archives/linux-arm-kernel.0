From: monstr@monstr.eu (Michal Simek)
Date: Tue, 6 Dec 2016 13:40:42 +0100
Subject: [GIT PULL] ARM: Xilinx Zynq DT changes for v4.10
Message-ID: <0eeda910-d585-d532-96c6-5c0cc634627c@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please add these changes to your arm-soc repo.
It fixes dtc warnings, small coding style changes and add support for
Microzed.

Thanks,
Michal

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.10

for you to fetch changes up to df2f3c48b9cd51e2612a1598342769d09d849f39:

  arm: dts: zynq: Add MicroZed board support (2016-12-06 13:17:39 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v4.10

- Remove skeleton.dtsi
- Fix DTC warnings
- Coding style changes
- Microzed support

----------------------------------------------------------------
Jagan Teki (1):
      arm: dts: zynq: Add MicroZed board support

Michal Simek (3):
      ARM: zynq: Remove skeleton.dtsi
      ARM: zynq: Fix W=1 dtc 1.4 warnings
      ARM: zynq: Fix pmu register description coding style

 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/zynq-7000.dtsi      | 10 +++++---
 arch/arm/boot/dts/zynq-microzed.dts   | 96
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-parallella.dts |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts      |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts      |  2 +-
 arch/arm/boot/dts/zynq-zed.dts        |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts       |  2 +-
 8 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-microzed.dts

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161206/e3325f57/attachment-0001.sig>
