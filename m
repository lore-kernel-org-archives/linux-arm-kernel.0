From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 6 Oct 2010 09:13:06 +0200 (CEST)
Subject: MX3: compile breakage with next
Message-ID: <Pine.LNX.4.64.1010060857280.9687@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to build an i.MX31 kernel with yesterday's next, getting this:

  CC      arch/arm/kernel/setup.o
/tmp/cc20jofu.s: Assembler messages:
/tmp/cc20jofu.s:131: Error: selected processor does not support ARM mode `isb'
make[1]: *** [arch/arm/kernel/setup.o] Error 1
make: *** [arch/arm/kernel] Error 2

Is it known? Any fix yet?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
