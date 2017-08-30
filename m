From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 30 Aug 2017 05:01:03 +0200
Subject: [PATCH 0/7] [DTS] enable hardware for Nanopi M1 & Nanopi M1 Plus
Message-ID: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

This Patchseries enables the IR controller and the dwmac-sun8i
on the Friendlyarm Nanopi M1 and Friendlyarm Nanopi M1 Plus boards.
On the Nanopi M1 Plus additionally the BT/Wifi module is activated.

Philipp Rossak (7):
  ARM: dts: sun8i: h3: nanopi-m1: Enable IR controller
  ARM: dts: sun8i: h3: nanopi-m1-plus: Enable IR controller
  ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1 Plus
  ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on Nanopi M1 Plus
  ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1
  ARM: dts: sun8i: h3: Adding UART3 RTS and CTS Pins
  ARM: dts: sun8i: h3: Enable AP6212 BT on uart3 on Nanopi M1 Plus

 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 80 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts      | 17 ++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  5 ++
 3 files changed, 102 insertions(+)

-- 
2.7.4
