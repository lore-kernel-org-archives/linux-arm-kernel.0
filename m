From: frank.wang@rock-chips.com (Frank Wang)
Date: Fri,  2 Jun 2017 11:20:22 +0800
Subject: [PATCH v2 0/4] fix some issues for Rockchip usb2-phy and add rk3228
 SoCs' support
Message-ID: <1496373626-27856-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series of patches fix some issues for rockchip usb2-phy and amend
usb2-phy framework to support one phy which comprises with two host-ports.

In addition, this change also add rk3228 usb2-phy support.

Changes from v1:
 - Replaced rk322x with rk3228 for PATCH 4/4.
 - Included devicetree people in the recipient list.

Frank Wang (1):
  phy: rockchip-inno-usb2: add support of usb2-phy for rk3228 SoCs

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
