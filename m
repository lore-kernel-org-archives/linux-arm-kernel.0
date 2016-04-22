From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 22 Apr 2016 13:51:43 +0800
Subject: [PATCH RESEND v2 0/4] ARM64: dts: rockchip: add support for RK3399
Message-ID: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dtsi file for RK3399 SoCs, and evb dts file for RK3399 evb.

To make patch more easily to be reviewed, some nodes have been removed
temporarily, after this base file been applied, more patches will be
upstreamed independently.

Jianqun Xu (3):
  ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
  ARM64: dts: rockchip: add RK3399 evaluation board
  ARM64: dts: rockchip: add dts file for RK3399 evaluation board

Shawn Lin (1):
  Documentation: rockchip-dw-mshc: add description for rk3399

 Documentation/devicetree/bindings/arm/rockchip.txt |    6 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  122 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 1022 ++++++++++++++++++++
 5 files changed, 1151 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi

--
changes in v2:
- split into more patches. (Heiko)
- remove arm-pmu at first. (Marc, Heiko, Mark)
- remove rga, emmc, usb3, mipi, edp, pd, i2c, gpu, thermal, tsadc, saradc, which will upstream independently
- remove rk808 since without i2c, which will upstream independently
- remove es8316 since without i2c, which will upstream independently
- add rockchip-dw-mshc binding patch
- add rockchip,rk3399-evb binding patch
- fix codingstyle issues

1.9.1
