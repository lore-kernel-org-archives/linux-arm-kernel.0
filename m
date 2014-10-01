From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed,  1 Oct 2014 18:20:40 +0800
Subject: [PATCH 0/3] Rockchip IOMMU driver and devicetree bindings
Message-ID: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a driver and devicetree bindings for the IOMMU found in Rockchip RK3288
SoCs.

Daniel Kurtz (3):
  iommu/rockchip: rk3288 iommu driver
  dt-bindings: iommu: Add documentation for rockchip iommu
  ARM: dts: rk3288: add VOP iommu nodes

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |  26 +
 arch/arm/boot/dts/rk3288.dtsi                      |  18 +
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/rockchip-iommu.c                     | 924 +++++++++++++++++++++
 5 files changed, 980 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
 create mode 100644 drivers/iommu/rockchip-iommu.c

-- 
2.1.0.rc2.206.gedb03e5
