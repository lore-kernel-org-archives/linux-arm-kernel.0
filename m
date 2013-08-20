From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Aug 2013 09:46:36 +0200
Subject: [GIT PULL] Allwinner sunXi DT additions for 3.12, take 2
Message-ID: <20130820074636.GA11668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 629ae88e9cebc6281bc54be743a33eca47b7228c:

  ARM: sunxi: dt: Add device tree for Mele A1000 (2013-08-14 09:59:20 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.12-2

for you to fetch changes up to e476ac8b483de4ce1d8570509be343afc7cd3baf:

  ARM: sun7i: Add Olimex A20-Olinuxino-Micro support (2013-08-20 08:18:45 +0200)

----------------------------------------------------------------
Allwinner sunXi DT additions for 3.12, take 2

These patches add basic support for:
  - Allwinner A31 and A20 SoCs
  - The Olimex A20-Olinuxino board
  - The Olimex A10s-Olinuxino board

----------------------------------------------------------------
Maxime Ripard (4):
      ARM: sunxi: Add Allwinner A31 DTSI
      ARM: sun6i: Add WITS Colombus A31 evaluation kit support
      ARM: sun7i: Add Allwinner A20 DTSI
      ARM: sun7i: Add Olimex A20-Olinuxino-Micro support

 arch/arm/boot/dts/Makefile                      |   4 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |  30 +++++
 arch/arm/boot/dts/sun6i-a31.dtsi                | 156 +++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  34 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 172 ++++++++++++++++++++++++
 5 files changed, 395 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-colombus.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/a6a3529d/attachment.sig>
