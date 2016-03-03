From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 3 Mar 2016 14:12:03 +0530
Subject: [PATCH 0/2] ARM: dra7: Enable Errata i877
Message-ID: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables Errata i877 for all DRA7 platforms. The public errata
documentation can be found here[1].

[1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf

Lokesh Vutla (1):
  ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property

Mugunthan V N (1):
  ARM: dts: dra7: do not gate cpsw clock due to errata i877

 Documentation/devicetree/bindings/arm/omap/omap.txt |  1 +
 arch/arm/boot/dts/dra7.dtsi                         | 10 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.c                    |  9 ++++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    |  3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.1.4
