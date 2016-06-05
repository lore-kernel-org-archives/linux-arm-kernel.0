From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  5 Jun 2016 13:48:10 +0000
Subject: [PATCH 0/4] ARM: dts: mxs: fix dtc warnings
Message-ID: <1465134490-13383-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes some dtc warnings for the mxs platform.

The first patch has been tested with real hardware. The others are
only compile tested.

Stefan Wahren (4):
  ARM: dts: mxs: add missing reg properties for GPIO banks
  ARM: dts: imx28-eukrea-mbmx28lc: add missing reg properties
  ARM: dts: imx28-cfa10049: fix dtc warning
  ARM: dts: imx28-tx28: fix dtc warning

 arch/arm/boot/dts/imx23.dtsi                 |    3 +++
 arch/arm/boot/dts/imx28-cfa10049.dts         |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi |    4 ++++
 arch/arm/boot/dts/imx28-tx28.dts             |    2 +-
 arch/arm/boot/dts/imx28.dtsi                 |    5 +++++
 5 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.9.5
