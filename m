From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 14 Aug 2014 16:13:31 -0500
Subject: [PATCHv2 0/3] ARM: dts: socfpga: updates for SOCFPGA
Message-ID: <1408050814-28595-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Just a few DTS updates for the SOCFPGA platform.

v2:
patch 1/3 : same as v1
patch 2/3 : same as v1
patch 3/3 : Added a single line comment for /memreserve/

Dinh Nguyen (3):
  ARM: dts: socfpga: remove extra alias in the ArriaV devkit
  ARM: dts: socfpga: Add SD card detect
  ARM: dts: socfpga: memreserve first 4KB for SMP code

 arch/arm/boot/dts/socfpga_arria5.dtsi        | 2 ++
 arch/arm/boot/dts/socfpga_arria5_socdk.dts   | 7 -------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi      | 4 +++-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 4 ++++
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.0.3
