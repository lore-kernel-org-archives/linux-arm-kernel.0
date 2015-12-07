From: yankejian@huawei.com (yankejian)
Date: Mon, 7 Dec 2015 16:25:05 +0800
Subject: [PATCH v2 next 0/2] dts: hisi: fixes no syscon error when init mdio
Message-ID: <1449476707-224320-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patchset fixes the bug that eth can't initial successful on hip05-D02
because the dts files doesn't match the source code.

yankejian (2):
  dts: hisi: fixes no syscon error when init mdio
  net: hns: fixes no syscon error when init mdio

---
change log:
v2:
 1) update the related documented in the binding as well
 2) use the normal naming conventions using '-' instead of '_', and
    update the related *.c files.

v1:
 initial version

 .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi                 |  5 +++++
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi             |  4 ++--
 drivers/net/ethernet/hisilicon/hns_mdio.c                |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
1.9.1
