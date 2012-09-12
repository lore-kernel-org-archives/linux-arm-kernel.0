From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Sep 2012 13:56:21 +0100
Subject: [RFC PATCH] ARM: mm: ADD descriptor string to
 CONFIG_DMA_ADDR_64BIT_T
In-Reply-To: <5050841A.7030203@ti.com>
References: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
 <5050841A.7030203@ti.com>
Message-ID: <20120912125621.GC21823@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 01:46:18PM +0100, Cyril Chemparathy wrote:
> On 9/12/2012 1:50 AM, R Sricharan wrote:
> > Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
> > the feature is not getting selected.
> > Adding a string description in the Kconfig resolves this.
> >
> > But not sure if this is the right way to fix this.
> 
> Shouldn't you be selecting this in your 64-bit dma address capable arch 
> instead?

Yes, that's how it was meant to be used.

-- 
Catalin
