From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 21 Jun 2013 08:36:42 +0200
Subject: [GIT PULL] arm-soc: Xilinx Zynq defconfig changes for v3.11
Message-ID: <05a3d74f-3f00-477f-a986-f06c5d2730b0@CO1EHSMHS027.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

I have created zynq/defconfig branch and added there two Soren's patches
as we discussed.
There is no any other dependency.

Thanks,
Michal


The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-defconfig-for-3.11

for you to fetch changes up to c12d82b84353784f8233c28ee43cec0ac9fbd7d2:

  arm: multi_v7_defconfig: Enable initrd/initramfs support (2013-06-21 08:19:32 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq defconfig changes for v3.11

Enable zynq uartps driver and initrd in defconfig.

----------------------------------------------------------------
Soren Brinkmann (2):
      arm: multi_v7_defconfig: Enable Zynq UART driver
      arm: multi_v7_defconfig: Enable initrd/initramfs support

 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)
