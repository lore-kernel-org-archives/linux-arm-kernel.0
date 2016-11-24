From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Nov 2016 21:15:11 +0100
Subject: [PATCH renesas-next 0/3] ARM: dts: shmobile: Use SoC-specific compat
 string for mmcif
Message-ID: <1480018514-31718-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series makes add of SoC-specific compat strings to the DT of
the r8a73a4, r8a7778 and sh73a0 SoCs. This is in keeping with the
rest of the Renesas ARM based SoCs with mmcif enabled in mainline.

Based on renesas-devel-20161123v2-v4.9-rc6

Documentation of these compat strings for the mmcif driver has been posted
separately as:
  "[PATCH] mmc: sh_mmcif: Document r8a73a4, r8a7779 and sh73a0 DT bindings".

Simon Horman (3):
  ARM: dts: r8a73a4: Use SoC-specific compat string for mmcif
  ARM: dts: r8a7778: Use SoC-specific compat string for mmcif
  ARM: dts: sh73a0: Use SoC-specific compat string for mmcif

 arch/arm/boot/dts/r8a73a4.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 arch/arm/boot/dts/sh73a0.dtsi  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
