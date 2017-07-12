From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu, 13 Jul 2017 00:03:50 +0800
Subject: [PATCH 0/5] arm64: dts: add rk3399 display-related nodes
Message-ID: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches add the display-related nodes for rk3399.

Tested with kernel base on drm-misc and below patches.
https://cgit.freedesktop.org/drm/drm-misc/
"drm: bridge: synopsys/dw-hdmi: Provide default configuration function for HDMI 2.0 PHY"
"iommu/rockchip: Enable Rockchip IOMMU on ARM64"

HDMI could work and have a display output.
eDP could link with panel but i didn't get a display(Maybe something wrong in power things).

For convenience, i think we should have those nodes in kernel now.


Jacob Chen (5):
  arm64: dts: rockchip: Add rk3399 vop and display-subsystem
  arm64: dts: rockchip: add pd_edp node for rk3399
  arm64: dts: rockchip: add rk3399 edp nodes
  arm64: dts: rockchip: add rk3399 mipi nodes
  arm64: dts: rockchip: add rk3399 hdmi nodes

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 198 +++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

-- 
2.7.4
