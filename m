From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  5 Jun 2018 22:16:59 -0700
Subject: [PATCH v2 0/3] arm64: allwinner: a64: Add initial support for Pinebook
Message-ID: <20180606051702.6478-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds dts for Pinebook with few prerequisites - PWM and R_I2C
devices nodes.

v2: - add my signoff
    - add default pinmux option for PWM
    - add alternate pinmux option for R_I2C controller
    - add A64 compatible for R_I2C controller

Andre Przywara (1):
  arm64: dts: allwinner: a64: Add PWM controllers

Icenowy Zheng (2):
  arm64: dts: allwinner: a64: add R_I2C controller
  arm64: dts: allwinner: add support for Pinebook

 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 280 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  56 ++++
 3 files changed, 337 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts

-- 
2.17.1
