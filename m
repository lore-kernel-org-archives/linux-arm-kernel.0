From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:11:36 +0100
Subject: [PATCH 0/3] arm64: introduce the Alpine support
Message-ID: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series introduces the support for the arm64 Alpine family from
Annapurna Labs, by adding a device tree for the Alpine v2 EVP. This
board has 4 Cortex A57 and a few nodes in its device tree for now.

You can find the series at:
https://github.com/atenart/linux.git 4.5-rc1/alpinev2-bringup

Antoine

Antoine Tenart (3):
  arm64: add Alpine SoC family
  arm64: dts: add the Alpine v2 EVP
  arm64: defconfig: enable the Alpine family

 arch/arm64/Kconfig.platforms             |   6 +
 arch/arm64/boot/dts/Makefile             |   1 +
 arch/arm64/boot/dts/al/Makefile          |   5 +
 arch/arm64/boot/dts/al/alpine-v2-evp.dts |  46 +++++++
 arch/arm64/boot/dts/al/alpine-v2.dtsi    | 221 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |   1 +
 6 files changed, 280 insertions(+)
 create mode 100644 arch/arm64/boot/dts/al/Makefile
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2-evp.dts
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2.dtsi

-- 
2.7.0
