From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 19:44:54 -0500
Subject: [PATCH 0/2] ARM: dts: Update the missing entries for KVM
Message-ID: <1385253896-30241-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small series updates GIC node in keystone dts file towards
KVM support.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>

Santosh Shilimkar (2):
  ARM: dts: keystone: Add the GICV and GICH address space
  ARM: dts: keystone: Add guestos maintenance interrupt

 arch/arm/boot/dts/keystone.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
1.7.9.5
