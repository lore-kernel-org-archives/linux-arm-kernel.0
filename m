From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Thu, 28 Apr 2016 15:09:00 +0800
Subject: [PATCH net-next 0/4] net: hns: update DT properties according to
 Rob's comments
Message-ID: <1461827344-52230-1-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some inappropriate properties definition in hns DT. We update the definition
according to Rob's review comments and fix some typos in binding.

For more details, please see individual patches.

MBR.

Yisen Zhuang (4):
  net: hns: remove cpld-ctrl-reg and add cell in the cpld-syscon
    property
  net: hns: change port-id property to reg property in dsaf port node
  Documentation: Bindings: Update DT binding for hns dsaf node
  dts: hisi: update hns dst for changing property port-id to reg

 .../devicetree/bindings/net/hisilicon-hns-dsaf.txt | 28 +++++++++----------
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi       | 10 ++++---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  | 32 ++++++++++++----------
 3 files changed, 36 insertions(+), 34 deletions(-)

-- 
1.9.1
