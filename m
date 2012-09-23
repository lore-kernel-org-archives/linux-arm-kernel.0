From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 23 Sep 2012 15:57:50 +1200
Subject: vt8500: multiplatform for 3.8
Message-ID: <1348372670.28422.6.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just took a cursory look over the work required for enabling
multiplatform support for v3.8 for arch-vt8500.

There are 2 files I don't know what to do with in
arch-vt8500/include/mach:

1) entry-macro.S
Contains some low-level irq macro's.

2) irqs.h
Only contains '#define NR_IRQS 128' so I thought it would be easy enough
to get rid of, but it looks like I need to enable SPARSE_IRQ to drop it,
which will require some coding - what exactly is SPARSE_IRQ and what's
required to make it work?

Regards

Tony P
