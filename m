From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue, 29 Jul 2014 18:31:09 -0700
Subject: [PATCH 0/4] usb: dwc2: add suport for Rockchip dwc2 controller
In-Reply-To: <963258>
References: <963258>
Message-ID: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This path is to add the support for dwc2 controller found ind
Rockchip processors rk3066, rk3188 and rk3288

This patch also add dr_mode for dwc2 driver.

Kever Yang (4):
  Documentation: dt-bindings: add dt binding info for Rockchip dwc2
  ARM: dts: add rk3288 dwc2 controller support
  usb: dwc2: add compatible data for rockchip soc
  usb: dwc2: add dr_mode support for dwc2

 Documentation/devicetree/bindings/usb/dwc2.txt |    5 ++++
 arch/arm/boot/dts/rk3288.dtsi                  |   20 ++++++++++++++
 drivers/usb/dwc2/core.c                        |   13 ++++++++++
 drivers/usb/dwc2/core.h                        |    2 ++
 drivers/usb/dwc2/platform.c                    |   33 ++++++++++++++++++++++++
 5 files changed, 73 insertions(+)

-- 
1.7.9.5
