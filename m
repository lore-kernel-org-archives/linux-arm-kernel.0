From: merker@debian.org (Karsten Merker)
Date: Thu, 10 Dec 2015 21:31:58 +0100
Subject: [PATCH 0/3] ARM: dts: sun7i: Olimex A20-SOM-EVB: LRADC-keys,
 MMC3 and typo fix in the sunxi LRADC binding
Message-ID: <1449779521-754-1-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the Olimex A20-SOM-EVB is an evaluation board for the Olimex
A20-SOM system-on-module. This patchset adds/enables some more
hardware features in the board dts:

  - Patch 1 adds support for the LRADC-keys on the baseboard.

  - Patch 2 enables the MMC3 controller to allow use of the
    full-size SD card socket on the baseboard.

While adding the LRADC-keys support, I have stumbled over
a typo in the bindings documentation. Patch 3 fixes that.

Regards,
Karsten

Karsten Merker (3):
  ARM: dts: sun7i: Olimex A20-SOM-EVB: Add LRADC keys
  ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3 (baseboard SD socket)
  ARM: dts: sunxi: allwinner,sun4i-a10-lradc-keys binding: typo fix

 .../devicetree/bindings/input/sun4i-lradc-keys.txt |  2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     | 73 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.1.4
