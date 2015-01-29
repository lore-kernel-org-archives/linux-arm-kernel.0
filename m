From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Jan 2015 15:34:39 +0100
Subject: [GIT PULL] Zynq DT for v3.20
Message-ID: <f7d1aa36395e40b4b6049208e2d8fe2f@BL2FFO11FD034.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these patches to your tree.

Thanks,
Michal

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-3.20

for you to fetch changes up to ab216ac5a236756c4560ff7f07ec7e206acdf078:

  ARM: zynq: DT: Add aliases node (2015-01-28 15:18:32 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.20

- Add USB chipidea driver to DT
- Add pincontrol
- Add aliases node
- Fix WDT node

----------------------------------------------------------------
Michal Simek (2):
      ARM: zynq: DT: Fix binding for cadence WDT
      ARM: zynq: DT: Add aliases node

Soren Brinkmann (4):
      ARM: zynq: DT: Add USB to device tree
      ARM: zynq: DT: Add pinctrl information
      ARM: zynq: DT: Remove bogus value from 'bias-disable' property
      ARM: zynq: DT: Add pinctrl information to USB nodes

 arch/arm/boot/dts/zynq-7000.dtsi |  32 +++++++--
 arch/arm/boot/dts/zynq-zc702.dts | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zed.dts   |  15 +++++
 4 files changed, 461 insertions(+), 4 deletions(-)
