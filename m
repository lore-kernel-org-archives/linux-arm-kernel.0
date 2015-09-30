From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 30 Sep 2015 21:17:45 +0200
Subject: [PATCH 0/5] ARM: dts: rockchip: some regulator updates for popmetal
 and firefly
Message-ID: <1443640670-21104-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The upcoming mmc tuning definitly needs correct handling of the iodomains,
which is also good to have in general. So this fixes some small regulator
issues and then adds the io-domains for the rk3288 popmetal and firefly
boards.

Heiko Stuebner (5):
  ARM: dts: rockchip: add rk3288-popmetal board to dtb list
  ARM: dts: rockchip: add rk3288-popmemtal mmc supplies
  ARM: dts: rockchip: add rk3288-popmetal iodomains
  ARM: dts: rockchip: fixup firefly mmc supplies
  ARM: dts: rockchip: add rk3288-firefly iodomains

 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/rk3288-firefly.dtsi | 55 +++++++++++++++++++++--
 arch/arm/boot/dts/rk3288-popmetal.dts | 85 +++++++++++++++++++++++++++++++++--
 3 files changed, 134 insertions(+), 7 deletions(-)

-- 
2.5.3
