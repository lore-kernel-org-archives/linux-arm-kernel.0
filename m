From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 18 May 2017 11:42:58 +0800
Subject: [PATCH 0/4] fix some issues for Rockchip usb2-phy and add rk322x
 SoCs' support
Message-ID: <1495078982-2555-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series of patches fix some issues for rockchip usb2-phy and amend
usb2-phy framework to support one phy which comprises with two host-ports.

In addition, this change also add rk322x usb2-phy support.

Frank Wang (1):
  phy: rockchip-inno-usb2: add support of usb2-phy for rk322x SoCs

William Wu (3):
  phy: rockchip-inno-usb2: add a delay after phy resume
  phy: rockchip-inno-usb2: increase otg sm work first schedule time
  phy: rockchip-inno-usb2: add one phy comprises with two host-ports    
    support

 .../bindings/phy/phy-rockchip-inno-usb2.txt        |  1 +
 drivers/phy/phy-rockchip-inno-usb2.c               | 74 ++++++++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.0.0
