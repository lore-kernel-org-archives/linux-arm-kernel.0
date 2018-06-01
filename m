From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 31 May 2018 23:28:58 -0700
Subject: [PATCH 0/3] arm64: allwinner: a64: Add initial support for Pinebook
Message-ID: <20180601062901.8052-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds dts for Pinebook with few prerequisites - PWM and R_I2C
devices nodes.

Andre Przywara (1):
  dts: sunxi: A64: Add PWM controllers

Icenowy Zheng (2):
  arm64: allwinner: a64: add R_I2C controller
  arm64: dts: allwinner: add support for Pinebook

 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 285 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 +++
 3 files changed, 331 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts

-- 
2.17.1
