From: r.sricharan@ti.com (Sricharan R)
Date: Mon, 16 Jun 2014 17:40:20 +0530
Subject: [PATCH V3 0/2] arm: dts: dra7: add crossbar dt support
Message-ID: <1402920622-7998-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces DT support for crossbar device and
changes dra7 peripherals to use crossbar number instead of irq.

This depends on below driver fixes and cleanup series.

https://lkml.org/lkml/2014/6/16/218

[V2] Rebased on 3.15 mainline.
[V3] Added ti,irqs-skip property and ti,irqs-safe-map property to
     crossbar dt node.

R Sricharan (2):
  arm: dts: dra7: add routable-irqs property for gic node
  arm: dts: dra7: add crossbar device binding

 arch/arm/boot/dts/dra7.dtsi |  136 +++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 58 deletions(-)

-- 
1.7.9.5
