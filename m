From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  9 Sep 2016 15:40:30 +0800
Subject: [PATCH 0/6] arm64: dts: rockchip: added some pd nodes for rk3399 Soc
Message-ID: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1.added the edp,emmc,perihp(pcie,usb2),sd,
sdioaudio(i2s,spdif,sdio,spi5),usb3 pd nodes
2.added the pd consumers node

Elaine Zhang (6):
  arm64: dts: rockchip: add pd_edp node for rk3399
  arm64: dts: rockchip: add pd_emmc power node for rk3399
  arm64: dts: rockchip: add pd_perihp power node for rk3399
  arm64: dts: rockchip: add pd_sd power node for rk3399
  arm64: dts: rockchip: add pd_sdioaudio power node for rk3399
  arm64: dts: rockchip: add pd_usb3 power node for rk3399

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

-- 
1.9.1
