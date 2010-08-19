From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 19 Aug 2010 16:39:53 +0200 (CEST)
Subject: [PATCH 0/5] Add API for DMA memory reservation for devices
Message-ID: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series attempts to solve the problem discussed here: 
http://marc.info/?t=128128236400002&r=1&w=2. It is a regression in 
2.6.36-rc1, so, we shall try to fix it ASAP. The series contains a couple 
of clean ups, the actual implementation and an example of using this new 
API. Tested on SuperH. Comments welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
