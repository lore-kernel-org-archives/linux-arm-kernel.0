From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 4 Apr 2013 09:41:30 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq core - pmu enable for v3.10
Message-ID: <8fadfba0-8f3d-4008-983b-259ed9e4f302@TX2EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull this dts change to your tree.
It enables pmu support for zynq.

Not sure if core branch is the correct one but feel free to rename it.

Thanks,
Michal


The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

   git://git.xilinx.com/linux-xlnx.git zynq/core

for you to fetch changes up to 268a820049531b130284943aeeb6ea38fd38e64c:

   arm: zynq: Add support for pmu (2013-04-04 09:23:44 +0200)

----------------------------------------------------------------
Michal Simek (1):
       arm: zynq: Add support for pmu

  arch/arm/boot/dts/zynq-7000.dtsi |    7 +++++++
  1 file changed, 7 insertions(+)
