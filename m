From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 Jan 2011 21:29:10 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20110101151545.GC25924@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<20110101151545.GC25924@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi==a7vSCnSewcjrTWeqhV47=fEwxG3qWaz6RWYh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> As a side note, the DMA mapping for slaves should be done using the
> DMA struct device, not the struct device of the peripheral making use
> of the DMA engine.

FYI I patched the amba-pl022.c for this (and your other immediate
comments) and it's queued for the next merge window.

Yours,
Linus Walleij
