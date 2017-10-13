From: phh@phh.me (Pierre-Hugues Husson)
Date: Sat, 14 Oct 2017 00:53:34 +0200
Subject: [PATCH 0/3] Enable CEC on rk3399
Message-ID: <20171013225337.5196-1-phh@phh.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CEC on firefly-rk3399.
Tested on a TV with cec-ctl --playback; cec-ctl -S

Pierre-Hugues Husson (3):
  drm: bridge: synopsys/dw-hdmi: Enable cec clock
  arm64: dts: rockchip: add the cec clk for dw-mipi-hdmi on rk3399
  arm64: dts: rockchip: enable cec pin for rk3399 firefly

 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |  8 ++++++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c       | 16 ++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.14.1
