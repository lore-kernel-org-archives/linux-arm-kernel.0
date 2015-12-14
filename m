From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Dec 2015 13:16:35 +0100
Subject: [GIT PULL] Xilinx Zynq DT changes for v4.5
Message-ID: <566EB323.2070309@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these changes to your tree.

Thanks,
Michal

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-4.5

for you to fetch changes up to 400b6a0cbef55d1ae32808eaa1ef1c28820bf6ac:

  ARM: dt: zynq: Add labels to cpu nodes to allow overriding OPPs.
(2015-12-14 09:48:39 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v4.5

- Various small DT changes, GPIO, slcr, cpu label

----------------------------------------------------------------
Masahiro Yamada (1):
      ARM: dts: zynq: describe SLCR as simple-mfd rather than simple-bus

Moritz Fischer (1):
      ARM: dt: zynq: Add labels to cpu nodes to allow overriding OPPs.

Soren Brinkmann (1):
      ARM: zynq: DT: Add interrupt-controller property to GPIO

Sudeep Holla (1):
      ARM: dts: zynq: replace gpio-key,wakeup with wakeup-source property

 arch/arm/boot/dts/zynq-7000.dtsi | 8 +++++---
 arch/arm/boot/dts/zynq-zc702.dts | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)
