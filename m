From: ayaka@soulik.info (Randy Li)
Date: Mon, 18 Jul 2016 23:32:31 +0800
Subject: [PATCH v2] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <1549971.ctkvOGm2xW@diego>
References: <1549971.ctkvOGm2xW@diego>
Message-ID: <1468855952-2006-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:

I use GPLv2 because of it looks more shorter, anyway I am back to allow
X11 now. The modification request of io-domain have been included.

Thank you for reviewing.

Randy Li (1):
  ARM: dts: add rk3288-firefly-reload

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  | 339 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts        | 356 +++++++++++++++++++++
 4 files changed, 700 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts

-- 
2.7.4
