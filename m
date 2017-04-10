From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Apr 2017 11:56:37 +0200
Subject: [GIT PULL 2/2] Rockchip dts64 updates for 4.12 part2
In-Reply-To: <2927359.zDIxDMQbjs@phil>
References: <2927359.zDIxDMQbjs@phil>
Message-ID: <1589941.s7YUBqhHWQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 41b464ef10219e45513d1bcaddacd47ce0bd6136:

  arm64: dts: rockchip: fix PCIe domain number for rk3399 (2017-03-22 17:50:09 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.12-rockchip-dts64-2

for you to fetch changes up to 2f513bd9eac1a2642b40387d4f89c3987641e59b:

  arm64: dts: rockchip: fix the memory size of PX5 Evaluation board (2017-04-07 22:29:11 +0200)

----------------------------------------------------------------
Basic support for new rk3328, a 4-core Cortex-A53 soc and a fix for the
default memory definition on the px5 eval board. While the bootloader
should already override it with the actual amount, it's better to not
carry around wrong values.

----------------------------------------------------------------
Andy Yan (1):
      arm64: dts: rockchip: fix the memory size of PX5 Evaluation board

Liang Chen (4):
      dt-bindings: add binding for rk3328-grf
      arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
      dt-bindings: document rockchip rk3328-evb board
      arm64: dts: rockchip: add RK3328 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |   57 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 1264 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |    2 +-
 6 files changed, 1328 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
