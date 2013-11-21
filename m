From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Nov 2013 12:11:35 +0000
Subject: CMA on AArch64
In-Reply-To: <20131121120559.GC22663@arm.com>
References: <528D2C7E.2010107@codeaurora.org> <20131121120559.GC22663@arm.com>
Message-ID: <20131121121135.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 12:06:00PM +0000, Catalin Marinas wrote:
> Hi Laura,
> 
> On Wed, Nov 20, 2013 at 09:41:18PM +0000, Laura Abbott wrote:
> > I noticed there is currently no CMA support for AArch64. Is this already 
> > on someone's TODO list or is this still open?
> 
> It's more like a wish list but there were other things that took
> priority. The arm64 DMA mapping code currently only supports swiotlb and
> our next plan is for IOMMU mapping. But I would like parts of the DMA
> IOMMU code under arch/arm to be made into a library (similar to the
> lib/swiotlb.c) so that other architectures can easily make use of it.

If you're referring to dmabounce.c, that's a 100% no-way-ever-even-if-
hell-freezes-over NACK.
