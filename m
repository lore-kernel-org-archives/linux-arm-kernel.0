From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jan 2015 11:56:29 -0600
Subject: [PATCH 0/3] Versatile AB/PB clocksource support
Message-ID: <1422467792-2065-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile clocksource driver can also be used on Versatile AB and PB 
platforms, not just Versatile Express. This series adds support for 
those boards.

I've split this off from the rest of the Versatile DT and 
multi-platform support as I'm not going to get it in place for 3.20. 
This part is fairly trivial and is ready to go.

Daniel, Can you please take the whole series.

Rob

Rob Herring (3):
  dt/bindings: Add binding for Versatile system registers
  clocksource: versatile: adapt for Versatile AB and PB boards
  dts: versatile: add sysregs node

 Documentation/devicetree/bindings/arm/versatile-sysreg.txt | 10 ++++++++++
 arch/arm/boot/dts/versatile-ab.dts                         |  5 +++++
 drivers/clocksource/versatile.c                            |  4 +++-
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/versatile-sysreg.txt

-- 
2.1.0
