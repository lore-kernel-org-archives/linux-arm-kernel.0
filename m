From: huangdaode@hisilicon.com (Daode Huang)
Date: Fri, 11 Mar 2016 17:10:40 +0800
Subject: [PATCH V2 net 0/6] net: hns: hns driver updates
Message-ID: <1457687446-109867-1-git-send-email-huangdaode@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

This patch series are hisilicon network driver bug fix.
please merge them to the net repo.
Thanks

Daode Huang
---
changlog
v2: some minor change according to 
    MBR Sergei <sergei.shtylyov@cogentembedded.com> in
    [patch 3/6] [patch 4/6].

v1: initial version.

Daode Huang (6):
  net: hns: bug fix about the overflow of mss
  net: hns: fixes the hw interrupt bug in using napi
  net: hns: fixed portid bug in sending manage pkt
  net: hns: adds uc match for debug port
  net: hns: fixed service-ges setting MAC-addr bug
  net: hns: bug fix of getting hilink status

 drivers/net/ethernet/hisilicon/hns/hnae.h          |  3 ++
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 29 +++++++++++----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 41 ++++++++++++----------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  4 +++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 32 +++++++++--------
 6 files changed, 70 insertions(+), 40 deletions(-)

-- 
1.9.1
