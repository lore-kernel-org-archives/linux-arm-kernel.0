From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 13 Oct 2017 18:41:36 +0800
Subject: [RESEND PATCH 0/2] rockchip: kevin: Enable edp display
Message-ID: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Make edp display works on chromebook kevin.


Jeffy Chen (2):
  spi: rockchip: Convert to late and early system PM callbacks
  arm64: dts: rockchip: Enable edp disaplay on kevin

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 29 +++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 16 +++++++++++++
 drivers/spi/spi-rockchip.c                        |  2 +-
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.11.0
