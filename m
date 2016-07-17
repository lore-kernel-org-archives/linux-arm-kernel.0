From: ayaka@soulik.info (Randy Li)
Date: Sun, 17 Jul 2016 23:38:56 +0800
Subject: [PATCH] ARM: dts: the dts support for rk3288 firefly reload
In-Reply-To: <5614243.tqTyZoc945@phil>
References: <5614243.tqTyZoc945@phil>
Message-ID: <1468769937-23387-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This version is split into a reload core dtsi for the SoC module
part and a baseboard dts for the reload baseboard. Thanks to
the Heiko's advise.

Randy Li (1):
  ARM: dts: add rk3288-firefly-reload

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  | 304 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts        | 320 +++++++++++++++++++++
 4 files changed, 629 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

-- 
2.7.4
