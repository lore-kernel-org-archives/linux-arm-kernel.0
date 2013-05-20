From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 16:13:47 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.11 (round 2)
Message-ID: <20130520201347.GM31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 53e9cb1dcde882cc667497328eca776a9835f965:

  ARM: dove: add si5351 clock driver to CuBox DT (2013-05-13 20:14:56 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.11-2

for you to fetch changes up to 8034891b81f0f7285c1efa3ae29e46b3f177536e:

  arm: mvebu: enable the third USB interface on OpenBlocks AX3 (2013-05-20 17:50:34 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.11 (round 2)

 - mvebu
    - standard mmc binding for mvsdio users
    - add NOR flash to Armada XP-DB
    - add 3rd usb interface on OpenBlocks AX3

 - kirkwood
    - dts files for sheevaplug and sheevaplug eSATA

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Add support for NOR flash device on Armada XP-DB board

Simon Baatz (2):
      ARM: mvebu: Use standard MMC binding for all users of mvsdio
      ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug

Thomas Petazzoni (1):
      arm: mvebu: enable the third USB interface on OpenBlocks AX3

 arch/arm/boot/dts/Makefile                         |  2 +
 arch/arm/boot/dts/armada-370-db.dts                |  1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |  1 +
 arch/arm/boot/dts/armada-370-rd.dts                |  1 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |  4 +
 arch/arm/boot/dts/armada-xp-db.dts                 | 33 ++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  9 ++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  1 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  2 +
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  | 97 ++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    | 40 +++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          | 45 ++++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |  1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |  4 +
 15 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug.dts
