From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 19:07:44 -0500
Subject: [PATCH 0/2] ARM: OMAP5: Couple of patches for KVM
Message-ID: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches for OMAP5 machines towards KVM support.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>

Santosh Shilimkar (2):
  ARM: dts: OMAP5: Add maintenance interrupt for virtualisation
  ARM: OMAP5: Add HYP mode entry support for secondary CPUs

 arch/arm/boot/dts/omap5.dtsi       |    1 +
 arch/arm/mach-omap2/omap-headsmp.S |    7 +++++++
 2 files changed, 8 insertions(+)

-- 
1.7.9.5
