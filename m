From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 17 Sep 2014 00:04:44 +0800
Subject: [PATCH v4 0/2] ARM: sun5i: Add DT for HSG H702 tablet board
Message-ID: <1410883486-22888-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v4 of the HSG H702 tablet support patch. I've split the original
patch into 2, one for the common 5V regulator, and the other for the
tablet.


Changes since v3
  - Move fixed regulator to common regulators in separate patch.
  - Use said common regulator for usb1-vbus. 
  - Slightly changed commit title

Changes since v2:
  - Dual license under GPL/X11.
  - Use extra fixed regulator for usb1-vbus.


Chen-Yu Tsai (2):
  ARM: dts: sunxi: Add fixed 5V regulator
  ARM: dts: sun5i: Add DT for HSG H702 tablet board

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts       | 130 +++++++++++++++++++++++++
 arch/arm/boot/dts/sunxi-common-regulators.dtsi |   7 ++
 3 files changed, 138 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts

-- 
2.1.0
