From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:27:10 +0800
Subject: [PATCH 0/2] arm64: hisilicon: add support hip06 d03 board
Message-ID: <1460100432-52722-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dts for Hip06 D03 board and documentation.

The Hip06 soc has same cpu topology compared with Hip05, four clusters
and each cluster has quard Cortex-A57, but with different IO part,
like HNS, SAS and PCI, they are all upgraded. There are also not same
in ITS, MBIGEN and SMMU, etc.

Note, there is no serial, because the soc use LPC uart, the serial node
is not needed.

Kefeng Wang (2):
  arm64: dts: Add initial dts for Hisilicon Hip06 D03 board
  Documentation: arm64: Add Hisilicon Hip06 D03 dts binding

 .../bindings/arm/hisilicon/hisilicon.txt           |  20 +-
 arch/arm64/boot/dts/hisilicon/Makefile             |   4 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |  34 +++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           | 307 +++++++++++++++++++++
 4 files changed, 356 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06-d03.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06.dtsi

-- 
1.7.12.4
