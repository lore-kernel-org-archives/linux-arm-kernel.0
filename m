From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 28 Oct 2015 16:02:15 -0500
Subject: [PATCH 0/2] Remove elm address space from omap4 hwmod
Message-ID: <1446066137-11527-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset removes elm address entry from omap4 hwmod and adds
an elm DT node to omap4.dtsi.

Since no omap4 supports nand in mainline this patchset was boot
tested on a pandaboard.

Franklin S Cooper Jr (2):
  ARM: dts: omap4: Add elm node
  ARM: omap4: hwmod: Remove elm address space from hwmod data

 arch/arm/boot/dts/omap4.dtsi               |  8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.6.1
