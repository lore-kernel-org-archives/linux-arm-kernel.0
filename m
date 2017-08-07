From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Aug 2017 11:30:51 +0800
Subject: [GIT PULL 2/3] Allwinner dts changes for 4.14
In-Reply-To: <20170807031910.66qj742m3egmdex5@wens.csie.org>
Message-ID: <20170807033051.idjrno7obvet6kqj@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c50f9fb6c535edf4731eecb53d91ebc297e82e5b:

  ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros (2017-07-27 21:18:48 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.14

for you to fetch changes up to 581ae76e96c6ab3bf942da7c4822ce9fa2074a01:

  ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC (2017-08-05 22:06:58 +0800)

----------------------------------------------------------------
The usual improvement patches:

  - R_INTC interrupt controller compatible string update and device node
    addition

  - Battery charger enabled on the Cubietruck

  - New board: Bananapi M2 Magic

  - Ethernet and USB OTG enabled on the Beelink X2

  - MMC enabled for A83T boards

----------------------------------------------------------------
Alexander Syring (1):
      ARM: dts: sun7i: enable battery power supply subnode on cubietruck

Chen-Yu Tsai (7):
      ARM: dts: sun6i: a31: Use new sun6i-a31-r-intc compatible for NMI/R_INTC
      ARM: dts: sun8i: a23/a33: Use new sun6i-a31-r-intc compatible for NMI/R_INTC
      ARM: dts: sun8i: a83t: Add device node for R_INTC interrupt controller
      ARM: dts: sun8i: a83t: Add MMC controller device nodes
      ARM: dts: sun8i: a83t: Add pingroup for 8-bit eMMC on mmc2
      ARM: dts: sun8i: a83t: cubietruck-plus: Enable micro-SD card and eMMC
      ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC

Marcus Cooper (2):
      ARM: dts: sun8i: h3: Enable USB OTG on the Beelink X2
      ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2

Maxime Ripard (1):
      ARM: dts: sun8i: Add BananaPI M2-Magic DTS

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   6 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   4 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   6 +-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  21 ++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  27 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  77 +++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |  31 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts       | 321 +++++++++++++++++++++
 9 files changed, 486 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/b6c52500/attachment.sig>
