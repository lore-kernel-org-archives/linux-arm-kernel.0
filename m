From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 May 2010 03:03:57 +0200
Subject: [PATCH 3/3] DMAENGINE: add PrimeCell generic DMA to PL022 v6
In-Reply-To: <h2te9c3a7c21005011748r234216a2o35c5a979e9e7f0ca@mail.gmail.com>
References: <1271481165-9848-1-git-send-email-linus.walleij@stericsson.com>
	<h2te9c3a7c21005011748r234216a2o35c5a979e9e7f0ca@mail.gmail.com>
Message-ID: <g2m63386a3d1005011803gb012d3adv9c347094f1bad8ed@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/2 Dan Williams <dan.j.williams@intel.com>:

> I just back-merged 2.6.34-rc4 into async-tx to pick up the
> gfp.h/slab.h conversion... prior to reading this patch. ?Can I just
> use v5?

You can, but I'll have to make some more amendments to it
for the stuff that Russell wants so as to keep all PrimeCells
uniform, so you could just as well hold it back a little while more.

Yours,
Linus Walleij
