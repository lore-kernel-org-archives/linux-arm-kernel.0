From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 17 Mar 2017 11:32:41 +0800
Subject: [PATCH 0/3] arm64: dts: rockchip: rk3368 add dmac and i2s nodes
Message-ID: <1489721564-32203-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add dmac, i2s nodes, and disable mailbox.

Jianqun Xu (3):
  arm64: dts: rockchip: add amba node support for RK3368 SoCs
  arm64: dts: rockchip: add i2s nodes support for RK3368 SoCs
  arm64: dts: rockchip: disable mailbox of RK3368 SoCs defaultly

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

-- 
1.9.1
