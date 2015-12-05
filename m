From: yankejian@huawei.com (yankejian)
Date: Sat, 5 Dec 2015 14:10:54 +0800
Subject: [PATCH net-next 0/2] net: hns: enet specisies a reference to dsaf
Message-ID: <1449295856-31068-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in this patchset, enet specifies a reference to dsaf. and delete the 
ae-name in enet, and adds parsing the ae-handle from DT to set the 
associating with dsaf.
the patchset updates the dtsi and bindings documents as well.

yankejian (2):
  net: hns: enet specisies a reference to dsaf
  net: hns: enet specisies a reference to dsaf (config and documents)

 .../devicetree/bindings/net/hisilicon-hns-dsaf.txt    |  5 +----
 .../devicetree/bindings/net/hisilicon-hns-nic.txt     |  7 ++++---
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi          | 19 +++++++++----------
 drivers/net/ethernet/hisilicon/hns/hnae.c             | 17 +++++++----------
 drivers/net/ethernet/hisilicon/hns/hnae.h             |  7 +++++--
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c     |  4 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c    | 10 +---------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h    |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c         | 13 +++++++++----
 drivers/net/ethernet/hisilicon/hns/hns_enet.h         |  2 +-
 10 files changed, 42 insertions(+), 43 deletions(-)

-- 
1.9.1
