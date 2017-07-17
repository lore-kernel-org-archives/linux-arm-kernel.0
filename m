From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 17 Jul 2017 10:20:51 +0900
Subject: [PATCH 0/5] phy: Replace the deprecated extcon API
References: <CGME20170717012057epcas1p11fe3d445ed16c7f94b57922b0a8f243a@epcas1p1.samsung.com>
Message-ID: <1500254456-6525-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches replace the deprecated extcon API
and remove them from extcon framework.

The patch1 and patch2 were already acked by Kishon Vijay Abraham I.
If patch3/patch4 are reviewed, I'll create the immutable branch
and send the pull request to both usb and phy maintainer.

Chanwoo Choi (5):
  phy: qcom-usb-hs: Replace the extcon API
  phy: rockchip-inno-usb2: Replace the extcon API
  phy: phy-bcm-ns2-usbdrd: Replace the deprecated extcon API
  usb: gadget: udc: Replace the deprecated extcon API
  extcon: Remove deprecated extcon_set/get_cable_state_()

 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |  8 ++++----
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        | 14 +++-----------
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 +++++-----
 drivers/usb/gadget/udc/snps_udc_plat.c        |  6 +++---
 include/linux/extcon.h                        | 11 -----------
 5 files changed, 15 insertions(+), 34 deletions(-)

-- 
1.9.1
