From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 29 Jul 2010 17:35:10 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <201007291026.55928.arnd@arndb.de>
References: <bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de>
Message-ID: <20100729173431Q.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Jul 2010 10:26:55 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 29 July 2010 05:35:48 FUJITA Tomonori wrote:
> > > 
> > > From what I have been able to tell, the IOMMU interface was written by
> > > AMD/Intel to allow the kvm code to work with a common IOMMU interface. To
> > 
> > Don't confuse the IOMMU interface with the DMA API that Arnd
> > mentioned.
> > 
> > They are not related at all.
> 
> Exactly, thanks for the clarification. I also didn't realize that there
> is now an include/linux/iommu.h file that only describes the PCI SR-IOV
> interfaces, unlike the generic IOMMU support that we have in your
> include/linux/dma-mapping.h file.
> 
> Maybe we should rename linux/iommu.h to something more specific so we
> can reduce this confusion in the future.

I also said that linux/iommu.h was a bad name when it was introduced
:) Well, the author disagreed. Now the name actually confuse
developers. The author might rethink.
