From: yankejian@huawei.com (Kejian Yan)
Date: Wed, 13 Jan 2016 11:01:11 +0800
Subject: [patch v3 net-next 0/2] dts: hisi: fixes no syscon fault when init
 mdio
In-Reply-To: <1452654073-28039-1-git-send-email-yankejian@huawei.com>
References: <1452654073-28039-1-git-send-email-yankejian@huawei.com>
Message-ID: <1452654073-28039-2-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the bug that eth can't initial successful on hip05-D02
because the dts files doesn't match the source code.

Kejian Yan (2):
  dts: hisi: fixes no syscon fault when init mdio
  net: hns: fixes no syscon error when init mdio
---
change log:
v3:
 1) uses capital letter at the beginning of sentences
 2) updates the right device node name

v2:
 1) update the related documented in the binding as well
 2) use the normal naming conventions using '-' instead of '_', and
    update the related *.c files.
v1:
 first submit

 .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi                 |  5 +++++
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi             |  4 ++--
 drivers/net/ethernet/hisilicon/hns_mdio.c                |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.4.1
