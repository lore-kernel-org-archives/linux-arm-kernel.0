From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 15:54:08 +0200
Subject: [PATCH 0/7] arm64: defconfig: enable some core components for
 Rockchip socs
Message-ID: <20170524135415.5590-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This contains enablement of newly supported Rockchip components
as well as some core drivers used in conjunction with
Rockchip socs but possibly also other devices.

If applicable, this should probably be applied to the arm-soc
arm64-defconfig branch, or I could provide a pull-request
for a branch if so desired.


Heiko Stuebner (7):
  arm64: defconfig: enable Rockchip pcie support
  arm64: defconfig: enable Rockchip saradc
  arm64: defconfig: enable keyboard_adc for adc-keys
  arm64: defconfig: enable Rockchip spi driver
  arm64: defconfig: enable more cros-ec options
  arm64: defconfig: enable Rockchip thermal controller
  arm64: defconfig: enable fan53555 regulator

 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.11.0
