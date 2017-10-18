From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 18 Oct 2017 07:22:05 -0400
Subject: [PATCH 0/3] arm64: dts: add more nodes and properities for
 hi3798cv200-poplar board
Message-ID: <1508325728-55823-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add more devices nodes and properties for poplar board, involving ir, emmc and pinctrl nodes.

Younian Wang (2):
  arm64: dts: hisilicon: supplement properties of ir node for poplar
    board
  arm64: dts: hisilicon: add pinctrl nodes for hi3798cv200-poplar board

tianshuliang (1):
  arm64: dts: hisilicon: supplement properties of emmc nodes for
    hi3798cv200-poplar board

 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  13 +
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |  81 ++-
 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi  | 651 +++++++++++++++++++++
 3 files changed, 742 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi

-- 
2.7.4
