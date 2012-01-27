From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 27 Jan 2012 16:59:11 +0200
Subject: [Linaro-mm-sig] [PATCH 12/15] drivers: add Contiguous Memory
 Allocator
In-Reply-To: <010301ccdd03$1ad15ab0$50741010$%szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-13-git-send-email-m.szyprowski@samsung.com>
 <CADMYwHw1B4RNV_9BqAg_M70da=g69Z3kyo5Cr6izCMwJ9LAtvA@mail.gmail.com>
 <00de01ccdce1$e7c8a360$b759ea20$%szyprowski@samsung.com>
 <CAO8GWqnQg-W=TEc+CUc8hs=GrdCa9XCCWcedQx34cqURhNwNwA@mail.gmail.com>
 <010301ccdd03$1ad15ab0$50741010$%szyprowski@samsung.com>
Message-ID: <CAK=WgbZWHBKNQwcoY9OiXXH-r1n3XxB=ZODZJN-3vZopU2yhJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/27 Marek Szyprowski <m.szyprowski@samsung.com>:
> Ohad, could you tell a bit more about your issue?

Sure, feel free to ask.

> Does this 'large region'
> is a device private region (declared with dma_declare_contiguous())

Yes, it is.

See omap_rproc_reserve_cma() in:

http://git.kernel.org/?p=linux/kernel/git/ohad/remoteproc.git;a=commitdiff;h=dab6a2584550a629746fa1dea2be8ffbe1910277

Thanks,
Ohad.
