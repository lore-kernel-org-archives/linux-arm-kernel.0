From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:18:41 +0800
Subject: [PATCH v2 0/2] AXP803 regulators support for Pine64 and SoPine
Message-ID: <20170722021843.6768-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 and SoPine w/ baseboard boards have an AXP803 PMIC, and the
regulators of the PMIC are used.

This patchset adds the regulators to the device tree of these two boards.

The first patch is for Pine64 and the second if for SoPine w/ official
baseboard.

The patches that drop the dummy regulators in v1 are removed.

Icenowy Zheng (2):
  arm64: allwinner: a64: enable AXP803 regulators for Pine64
  arm64: allwinner: a64: add AXP803 PMIC support to SoPine and the
    baseboard

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 102 +++++++++++++++++++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  23 +++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |  86 +++++++++++++++++
 3 files changed, 211 insertions(+)

-- 
2.13.0
