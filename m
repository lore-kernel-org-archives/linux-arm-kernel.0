From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Wed, 21 May 2014 10:28:19 +0100
Subject: [PATCH 0/2] Add generic GIC compat strings
Message-ID: <1400664501-4208-1-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the GIC (in drivers/irqchip/irq-gic.c) is referred to with
implementation-specific strings (e.g. "arm.cortex-a9-gic"), which is a
little unwieldy due to the number of different CPUs we now have with GIC
support.

These 2 patches add the generic arm,gic-v[1,2] compat strings and also change
the respective documentation.

Nikolay Borisov (2):
  irqchip: Add generic gic-v1/gic-v2 compat strings.
  documentation/devicetree: Update GIC compat strings

 Documentation/devicetree/bindings/arm/gic.txt | 2 ++
 drivers/irqchip/irq-gic.c                     | 2 ++
 2 files changed, 4 insertions(+)

-- 
1.8.1.5
