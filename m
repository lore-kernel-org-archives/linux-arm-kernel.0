From: sushaanth.s@ti.com (Sushaanth Srirangapathi)
Date: Mon, 1 Feb 2016 11:58:46 +0530
Subject: [PATCH 0/3] Add Device Tree support for tps6507x-ts
Message-ID: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for touchscreen input device tps6507x-ts which is part
of MFD device "TPS6507x"

Sushaanth Srirangapathi (3):
  Input: tps6507x-ts - add binding for tps6507x-ts
  Input: tps6507x-ts - Add device tree support
  ARM: DTS: da850: add DT node for tps6507x-ts

 Documentation/devicetree/bindings/mfd/tps6507x.txt |   10 +++-
 arch/arm/boot/dts/da850-evm.dts                    |    3 ++
 drivers/input/touchscreen/tps6507x-ts.c            |   51 ++++++++++++++++++--
 3 files changed, 59 insertions(+), 5 deletions(-)

-- 
1.7.9.5
