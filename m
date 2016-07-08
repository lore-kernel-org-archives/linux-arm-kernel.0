From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:04:54 +0800
Subject: [PATCH 0/7] Rockchip dw-mipi-dsi driver
Message-ID: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all

This is a bunch of dw-mipi-dsi driver for RK3399 and RK3288, they have
been tested on rk3399 and rk3288 evb board.

This series is based on Mark Yao's branch:
https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2016-05-23



Chris Zhong (7):
  dt-bindings: add rk3399 support for dw-mipi-rockchip
  DRM: mipi: support rk3399 mipi dsi
  dt-bindings: add power domain node for dw-mipi-rockchip
  drm/rockchip: dw-mipi: add dw-mipi power domain support
  drm/rockchip: dw-mipi: support HPD poll
  drm/rockchip: dw-mipi: fix phy clk lane stop state timeout
  drm/rockchip: dw-mipi: fix insufficient bandwidth of some panel

 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   6 +
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 135 +++++++++++++++++----
 2 files changed, 120 insertions(+), 21 deletions(-)

-- 
2.6.3
