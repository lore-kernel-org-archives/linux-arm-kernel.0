From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Mar 2013 21:02:36 +0000
Subject: [PATCH 1/2] ARM: exynos: pl330: Add #dma-cells for generic dma
 binding support
In-Reply-To: <015901ce1ad3$6ea43540$4bec9fc0$%kim@samsung.com>
References: <1362375268-29405-1-git-send-email-padma.v@samsung.com>
 <CAAgF-Bf+rqiFUaBD=aRqry6-2z4o0Ao2L2YRm8bu1x98TfPPyg@mail.gmail.com>
 <015901ce1ad3$6ea43540$4bec9fc0$%kim@samsung.com>
Message-ID: <201303112102.36909.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 March 2013, Kukjin Kim wrote:
> > Can you please take this patch in 3.9 rc2 ?
> > 
> Sure, I will.
> 
> BTW, Arnd, I'm not sure second one(socfpga.dtsi) can be handled in samsung
> tree.

I guess you're right, I've applied the second one to the fixes branch now.

Thanks,

	Arnd
