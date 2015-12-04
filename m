From: tony@atomide.com (Tony Lindgren)
Date: Fri,  4 Dec 2015 15:31:03 -0800
Subject: [PATCH 0/6] Add usb support for dm814x and dra62x
Message-ID: <1449271869-7614-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add usb support for dm814x and dra62x. These patches depend
on what's listed at the mmc patches at:

http://marc.info/?l=linux-omap&m=144919234321418&w=2

Regards,

Tony


Tony Lindgren (6):
  ARM: OMAP2+: Update 81xx clock and power domains for default, active
    and sgx
  ARM: OMAP2+: Add support for dm814x and dra62x usb
  ARM: dts: Add usb support for dm814x and dra62x
  ARM: dts: Add usb support for dm814x-evm
  ARM: dts: Add usb support for hp t410
  ARM: dts: Add usb support for j5-eco evm

 arch/arm/boot/dts/dm8148-evm.dts            |  24 ++++++
 arch/arm/boot/dts/dm8148-t410.dts           |  35 ++++++++
 arch/arm/boot/dts/dm814x.dtsi               | 125 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts      |  21 +++++
 arch/arm/mach-omap2/clockdomains81xx_data.c |  29 +++----
 arch/arm/mach-omap2/cm81xx.h                |   6 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  |  38 +++++++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  10 ++-
 8 files changed, 258 insertions(+), 30 deletions(-)

-- 
2.6.2
