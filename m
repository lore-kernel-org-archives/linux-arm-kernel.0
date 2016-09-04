From: andy.yan@rock-chips.com (Andy Yan)
Date: Sun,  4 Sep 2016 16:32:17 +0800
Subject: [PATCH 0/4] One fix and some improvements for RK3288 Popmetal board
Message-ID: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series fix one sensor i2c device address on Popmetal
board, and change some pinctrl description to make it more
clearly, also enable the usb otg function on this board.


Andy Yan (4):
  ARM: dts: rockchip: enable usbotg for Popemtal-rk3288 board
  ARM: dts: rockchip: fix i2c address L3G4200D on PopMetal-RK3288 board
  include: dt-bindings: Add more GPIO bank and index definition for
    rockchip pinctrl
  ARM: dts: use definition in rockchip pinctrl header to describe gpios
    on Popmetal-RK3288

 arch/arm/boot/dts/rk3288-popmetal.dts  | 36 +++++++++++++++++++++-------------
 include/dt-bindings/pinctrl/rockchip.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 14 deletions(-)

-- 
2.7.4
