From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 22 Jun 2016 10:53:58 +0800
Subject: [PATCH v3 0/4] Add the eDP/VOP device node for rk3399
Message-ID: <1466564038-18021-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This thread is rely on Mark's VOP thread[1] and Yakir's eDP thread[2].

[1]: https://lkml.org/lkml/2016/4/20/36
[2]: https://patchwork.kernel.org/patch/9175613/

Changes in v3:
- Add this patch in v3, due to another patch[0] need.
  [0]: https://patchwork.kernel.org/patch/9191737/

Changes in v2:
- provide some minimal patch description (Heiko)
- provide some minimal patch description (Heiko)
- provide some minimal patch description (Heiko)

Mark Yao (1):
  arm64: dts: rockchip: add VOP and VOP iommu node for rk3399

Yakir Yang (3):
  arm64: dts: rockchip: add eDP device node for rk3399
  arm64: dts: rockchip: add backlight support for rk3399 evb board
  arm64: dtsi: rockchip: introduce pclk_vio_grf in eDP device node

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  40 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 110 ++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

-- 
1.9.1
