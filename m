From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 3 Apr 2013 11:18:57 +0200 (CEST)
Subject: [PATCH/RFC 0/2] ARM: shmobile: DT irqpin for r8a7779 and
 marzen-reference
Message-ID: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

This 2 patches add DT irqpin support on marzen-reference. Only 
compile-tested due to the lack of hardware. The patches can go 
independently via their respective trees. irqpin on marzen will not work 
if patch 2 is applied before patch 1, but as long as there are no devices, 
using irqpin interrupts, no breakage will be caused.

Guennadi Liakhovetski (2):
      irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
      ARM: shmobile: marzen-reference: add irqpin support in DT

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
