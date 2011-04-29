From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 29 Apr 2011 10:29:22 +1000
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <BANLkTinhm7ar1mf1D-dSMiLtw5hRNY36RA@mail.gmail.com>
References: <201104212129.17013.arnd@arndb.de>
	<201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<201104281629.52863.arnd@arndb.de>
	<20110428143440.GP17290@n2100.arm.linux.org.uk>
	<BANLkTinhm7ar1mf1D-dSMiLtw5hRNY36RA@mail.gmail.com>
Message-ID: <1304036962.2513.202.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-28 at 15:37 -0400, Jerome Glisse wrote:
> Jesse also pointed out space exhaustion inside the iommu and i believe
> this should also be considered. This is why i believe the dma_* api is
> not well suited. In DRM/TTM we use  pci_dma_mapping* and we also play
> with with page set_page*_uc|wc|wb.

Which are yet another set of completely x86-centric APIs that have not
been thought in the context of other architectures and are probably
mostly unimplementables on half of them :-)

Cheers,
Ben.
