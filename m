From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Mar 2014 13:45:55 +0100
Subject: [PATCH 0/5] Kirkwood DT Documentation
Message-ID: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes up a number of issues found by checkpatch in the
kirkwood DT files or binding Documentation. Vendor Prefixes are
documented, missing prefixes are added, incorrect prefixes are
corrected, and Kirkwood SoCs are documented.

Note that some of these patches contain UTF-8 characters, which the
mailing lists sometime don't like. The patches can also be found in

https://github.com/lunn/linux.git v3.14-rc7-next-20140321-dt

which is based on linux-next tag next-20140321.

Andrew Lunn (5):
  DT: Vendor: Add prefixes used by Kirkwood devices
  DT: bindings: add missing Marvell Kirkwood SoC documentation
  ARM: Kirkwood: Fix Atmel vendor prefix
  DT: I2C: Add trivial bindings used by kirkwood boards
  ARM: Kirkwood: DT: Add missing vendor prefix

 .../devicetree/bindings/arm/marvell,kirkwood.txt   | 97 ++++++++++++++++++++++
 .../devicetree/bindings/i2c/trivial-devices.txt    | 16 ++++
 .../devicetree/bindings/vendor-prefixes.txt        | 13 ++-
 arch/arm/boot/dts/kirkwood-b3.dts                  |  2 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |  2 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  2 +-
 arch/arm/boot/dts/kirkwood-laplug.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  2 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  4 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-nsa310a.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  2 +-
 13 files changed, 136 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt

-- 
1.9.1
