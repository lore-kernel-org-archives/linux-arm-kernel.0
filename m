From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 22 Aug 2014 08:54:25 -0700
Subject: [PATCH 00/11] ARM: multi_v7_defconfig: Enable Zynq/Xilinx drivers
Message-ID: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I went through the defconfig and searched for Zynq drivers. The result is
this series of patches. The first few are all for Zynq and pretty much
straight forward. The second half is mostly soft-IP, I think. That
soft-IP works with Zynq devices, but I'm not sure whether those should
go into the multi_v7 defconfig.

	Soren

Soren Brinkmann (11):
  ARM: multi_v7_defconfig: Enable Zynq cpuidle driver
  ARM: multi_v7_defconfig: Enable Zynq/Xilinx CAN driver
  ARM: multi_v7_defconfig: Enable XADC driver
  ARM: multi_v7_defconfig: Enable Zynq SPI driver
  ARM: multi_v7_defconfig: Enable Zynq GPIO driver
  ARM: multi_v7_defconfig: Enable Xilinx I2C driver
  ARM: multi_v7_defconfig: Enable Xilinx SPI driver
  ARM: multi_v7_defconfig: Enable Xilinx GPIO driver
  ARM: multi_v7_defconfig: Enable Xilinx VDMA driver
  ARM: multi_v7_defconfig: Enable Xilinx emaclite driver
  ARM: multi_v7_defconfig: Enable Xilinx watchdog timer

 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.0.1.1.gfbfc394
