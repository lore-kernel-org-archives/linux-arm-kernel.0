From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 25 Feb 2013 18:16:23 +0100 (CET)
Subject: [PATCH/RFC v2 0/2] CPUFreq for kzm9g
Message-ID: <Pine.LNX.4.64.1302251644010.3030@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In v2 of this patch-set I dropped patches 1 and 3, because #1 is a bug-fix 
and can go in separately, #3 is more of a debugging help, than a real 
patch for mainlining. Of the remaining 2 patches the main difference to v1 
is the omission of the PLL0 manipulation. More is explained in respective 
patches.

Guennadi Liakhovetski (2):
  ARM: shmobile: sh73a0: add support for adjusting CPU frequency
  ARM: shmobile: kzm9g-reference: add CPUFreq support

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
