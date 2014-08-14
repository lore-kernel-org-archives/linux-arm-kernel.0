From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 14 Aug 2014 10:51:28 -0500
Subject: [PATCH 0/3] ARM: dts: socfpga: updates for SOCFPGA
Message-ID: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Just a few DTS updates for the SOCFPGA platform.

patch 1/3 : cleanup
patch 2/3 : Add a SD/MMC card detect entry
patch 3/3 : Add a /memserve/ section for the platform

Dinh Nguyen (3):
  ARM: dts: socfpga: remove extra alias in the ArriaV devkit
  ARM: dts: socfpga: Add SD card detect
  ARM: dts: socfpga: memreserve first 4KB for SMP code

 arch/arm/boot/dts/socfpga_arria5.dtsi        | 1 +
 arch/arm/boot/dts/socfpga_arria5_socdk.dts   | 7 -------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi      | 3 ++-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 4 ++++
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.0.3
