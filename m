From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 3 Sep 2015 09:40:21 +0200
Subject: Cortex A9 MP: ARM errata 754323 implementation?
Message-ID: <55E7F965.8080802@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

looking through the ARM Cortex A9 errata list [1] I wonder why we don't 
have a workaround for

(754323) Repeated Store in the same cache line might delay the 
visibility of the Store

in the kernel? Or have I missed it?

We do have the workaround for the related erratum #754327 implemented 
[2], but that is supposed only for cores prior to r2p0.

While #754323 seems to affect all newer cores, too?

Any idea?

Best regards

Dirk

[1] ARM Cortex-A9 processors
r4 releases
Software Developers Errata Notice
ARM UAN 0009D (ID032315)

[2] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/Kconfig#n1196
