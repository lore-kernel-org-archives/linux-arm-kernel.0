From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 16 Oct 2014 16:03:31 -0500
Subject: [PATCH 0/2] ARM: dts: socfpga: fix booting with SD/MMC
Message-ID: <1413493413-8041-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The SOCFPGA dev kit was hanging during bootup on the SD/MMC driver loading.
The first patch fixes the booting and the 2nd patch adds a regulator node
for the SD/MMC driver to use.

Dinh Nguyen (2):
  ARM: dts: socfpga: Fix SD card detect
  ARM: dts: socfpga: Add a 3.3V fixed regulator node

 arch/arm/boot/dts/socfpga_arria5.dtsi         | 11 ++++++++++-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    |  5 +++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi       |  9 +++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  |  4 +++-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |  5 +++++
 5 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.0.3
