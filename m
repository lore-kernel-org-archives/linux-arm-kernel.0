From: yankejian@huawei.com (yankejian)
Date: Sat, 28 Nov 2015 14:15:13 +0800
Subject: [PATCH net-next 0/3] dts: hisi: fixes can't find eth for hip05-D02
Message-ID: <1448691316-236111-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patchset fixes the bug that eth can't initial successful. because the
the dts files doesn't match the source code.

yankejian (3):
  dts: hisi: enables the ethX for D02 board
  dts: hisi: fixes no syscon error when init mdio
  arm64: hip05-d02: Document devicetree bindings for Hisilicon D02 Board

 .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts              | 16 ++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi                 |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi             |  4 ++--
 4 files changed, 38 insertions(+), 2 deletions(-)

-- 
1.9.1
