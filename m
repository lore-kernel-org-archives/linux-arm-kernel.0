From: lisheng011@huawei.com (Lisheng)
Date: Fri, 4 Mar 2016 12:40:48 +0800
Subject: [PATCH net 0/2] net: hns: fixed the pause ctl bug
Message-ID: <1457066450-72395-1-git-send-email-lisheng011@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change is for supporting pause in V2 chip:
	service ports can close pause-rx;
	debug ports can open pause-rx/tx.

Lisheng (2):
  net: hns: fixed the pause ctl bug
  net: hns: update pause regs to dump function

 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  | 20 +++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  | 30 +++------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 71 ++++++++++++++++++----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |  4 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  6 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  6 ++
 6 files changed, 98 insertions(+), 39 deletions(-)

-- 
1.9.1
