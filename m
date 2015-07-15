From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 19:58:59 +0100
Subject: [PATCH 0/7] Another posting of the Dove PMU series
Message-ID: <20150715185859.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What it says in the subject.  Not hopeful of a successful outcome, so I'm
not going to bother wasting time writing stuff here.

 Documentation/devicetree/bindings/soc/dove/pmu.txt |  56 ++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/dove.dtsi                        | 604 +++++++++++----------
 arch/arm/mach-dove/common.c                        |  25 +
 arch/arm/mach-dove/include/mach/pm.h               |  17 -
 arch/arm/mach-dove/irq.c                           |  87 ---
 arch/arm/mach-mvebu/Kconfig                        |   1 +
 arch/arm/mach-mvebu/dove.c                         |   2 +
 drivers/soc/Makefile                               |   2 +
 drivers/soc/dove/Makefile                          |   1 +
 drivers/soc/dove/pmu.c                             | 512 +++++++++++++++++
 include/linux/soc/dove/pmu.h                       |  24 +
 12 files changed, 942 insertions(+), 390 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
