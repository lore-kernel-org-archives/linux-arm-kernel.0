From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Wed, 21 Jul 2010 10:44:37 +0900
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100720221959.GC12250@codeaurora.org>
References: <20100715014148.GC2239@codeaurora.org>
	<20100719082213.GA7421@n2100.arm.linux.org.uk>
	<20100720221959.GC12250@codeaurora.org>
Message-ID: <20100721104356S.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jul 2010 15:20:01 -0700
Zach Pfeffer <zpfeffer@codeaurora.org> wrote:

> > I'm not saying that it's reasonable to pass (or even allocate) a 1MB
> > buffer via the DMA API.
> 
> But given a bunch of large chunks of memory, is there any API that can
> manage them (asked this on the other thread as well)?

What is the problem about mapping a 1MB buffer with the DMA API?

Possibly, an IOMMU can't find space for 1MB but it's not the problem
of the DMA API.
