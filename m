From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 23 May 2016 21:33:20 +0800
Subject: [PATCH 0/3] Add the eDP/VOP device node for rk3399
Message-ID: <1464010400-10903-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This thread is rely on Mark's VOP thread[1] and Yakir's eDP thread[2].

[1]: https://lkml.org/lkml/2016/4/20/36
[2]: https://patchwork.freedesktop.org/patch/83406/


Mark Yao (1):
  arm64: dts: rockchip: add VOP and VOP iommu node for rk3399

Yakir Yang (2):
  arm64: dts: rockchip: add eDP device node for rk3399
  arm64: dts: rockchip: add backlight support for rk3399 evb board

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  40 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 110 ++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

-- 
1.9.1
