From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 12 Jun 2014 17:35:45 +0530
Subject: [PATCH V2 0/2] ARM: dts: dra7: Add crossbar dt support
Message-ID: <1402574747-14359-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces DT support for crossbar device and
changes dra7 peripherals to use crossbar number instead of irq.

This depends on below driver fixes and cleanup series.

https://lkml.org/lkml/2014/6/12/232

[V2] Rebased on 3.15 mainline.

R Sricharan (2):
  ARM: dts: DRA7: Add routable-irqs property for gic node
  ARM: dts: DRA7: Add crossbar device binding

 arch/arm/boot/dts/dra7.dtsi |  134 ++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 58 deletions(-)

-- 
1.7.9.5
