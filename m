From: xzy.xu@rock-chips.com (Ziyuan Xu)
Date: Sat, 27 Aug 2016 21:41:01 +0800
Subject: [PATCH 0/2] Add power domain support for eMMC node on rk3399
Message-ID: <20160827134103.28160-1-xzy.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add power domain for eMMC node which will be controlled by
genpd to make sure it's available in probing state, and will be off
once suspend/remove.


Ziyuan Xu (2):
  Documentation: mmc: sdhci-of-arasan: add description of power domain
  arm64: dts: rockchip: add eMMC's power domain support for rk3399

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt |  6 +++++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi               | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.9.2
