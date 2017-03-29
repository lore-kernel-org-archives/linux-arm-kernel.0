From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 29 Mar 2017 14:30:07 +0800
Subject: [PATCH v3 0/2] add dts files for hi3798cv200-Poplar board
Message-ID: <1490769009-12552-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set mainly adds dts files for hi3798cv200-Poplar board.

Jiancheng Xue (2):
  dt-bindings: arm: hisilicon: add bindings for hi3798cv200 SoC and
    Poplar board
  arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board

 .../bindings/arm/hisilicon/hisilicon.txt           |   4 +
 arch/arm64/boot/dts/hisilicon/Makefile             |   1 +
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 163 +++++++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 405 +++++++++++++++++++++
 4 files changed, 573 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi

-- 
1.9.1
