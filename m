From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Oct 2013 19:22:20 +0200
Subject: [GIT PULL] Allwinner sunXi DT changes for 3.13
Message-ID: <20131018172220.GA14740@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof,

Please pull the following DT changes for the 3.13 merge window.

Thanks,
Maxime

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.13

for you to fetch changes up to 01ed6632a554dfdf4a9fc3c593ce4ff7255ed161:

  ARM: sunxi: dts: Add support for the cubieboard3, the CubieTruck (2013-10-08 11:35:19 +0200)

----------------------------------------------------------------
Allwinner sunXi SoCs device tree changes for 3.13

This DT series sees the introduction of the cubietruck DT, plus the addition of
the i2c controller for the A20 based boards, and of the Security ID found in
all the Allwinner SoCs but the A31.

----------------------------------------------------------------
Maxime Ripard (4):
      ARM: sun7i: Enable the I2C controllers
      ARM: sun7i: Add the pin muxing options for the I2C controllers
      ARM: sun7i: cubieboard2: Enable the I2C controllers
      ARM: sun7i: olinuxino-micro: Enable the I2C controllers

Oliver Schinagl (2):
      ARM: sunxi: dt: Add sunxi-sid to dts for sun4i, sun5i and sun7i
      ARM: sunxi: dts: Add support for the cubieboard3, the CubieTruck

 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/sun4i-a10.dtsi                |  5 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi               |  5 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                |  5 ++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 12 +++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 63 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 18 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 71 +++++++++++++++++++++++++
 8 files changed, 180 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-cubietruck.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/cc2a7f01/attachment-0001.sig>
