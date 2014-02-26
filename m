From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Feb 2014 12:08:58 +0000
Subject: [Linaro-mm-sig] CMA on AArch64
In-Reply-To: <BAY176-W60E53B94270FFBE9118BCAA800@phx.gbl>
References: <528D2C7E.2010107@codeaurora.org> <20131121120559.GC22663@arm.com>
 <BAY176-W60E53B94270FFBE9118BCAA800@phx.gbl>
Message-ID: <20140226120857.GA7409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 09:50:35AM +0000, Hwang Chih-Chyuan wrote:
> > Yet another feature is DMA cache coherency management (primarily
> > streaming DMA) and I have a patch but I want this driven via DT rather
> > than drivers or SoC code calling set_dma_ops explicitly (the bindings
> > definition is work in progress).
> 
> Is there the plan or the progress about this part (streaming DMA)?  :)

You can grab a patch here:

https://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/commit/?h=devel&id=96f083d416c0d01687ed5b37074831f461838455

However, I'd like to see some progress on defining the system topology
via DT rather than driver manually setting the dma ops. Dave Martin is
looking at this but I don't have an ETA yet.

-- 
Catalin
