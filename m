From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  9 Dec 2017 01:07:35 +0100
Subject: [PATCH 0/3] arm64: dts: Support Mali450 on rk3328
Message-ID: <20171209000738.32187-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pretty standard setup. Tested with the kmscube demo running
using the lima kernel and gallium driver.


Heiko Stuebner (3):
  dt-bindings: gpu: mali-utgard: add rockchip,rk3328-mali compatible
  arm64: dts: rockchip: add rk3328 mali gpu node
  arm64: dts: rockchip: enable gpu on rk3328-rock64

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  1 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  4 ++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 23 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)

-- 
2.14.2
