From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 10 Jun 2017 01:12:03 +0200
Subject: [PATCH 0/3] OMAP4: crypto support
Message-ID: <20170609231206.19798-1-sre@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds crypto support for OMAP4, which was missing for some reason.
This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
DES are working according to selftest.

-- Sebastian

Sebastian Reichel (3):
  ARM: dts: omap4: add missing des_fck
  ARM: OMAP4: hwmod data: add aes
  ARM: OMAP4: hwmod data: add des

 arch/arm/boot/dts/omap44xx-clocks.dtsi     |  8 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 78 ++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.11.0
