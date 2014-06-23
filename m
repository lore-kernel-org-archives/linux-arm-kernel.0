From: vbridgers2013@gmail.com (Vince Bridgers)
Date: Sun, 22 Jun 2014 19:31:00 -0500
Subject: [PATCH 0/2] ARM: socfpga: Update socfpga_defconfig and socfpga.dtsi
Message-ID: <1403483462-21082-1-git-send-email-vbridgers2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series updates the the socfpga_defconfig with a number of options,
and updates the socfpga device tree with a field required for the reset
controller driver. 

Vince Bridgers (2):
  ARM: socfpga: Update socfpga_defconfig
  ARM: socfpga: Add missing #reset-cells to socfpga device tree

 arch/arm/boot/dts/socfpga.dtsi     |    1 +
 arch/arm/configs/socfpga_defconfig |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

-- 
1.7.9.5
