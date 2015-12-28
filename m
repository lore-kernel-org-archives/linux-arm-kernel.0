From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 28 Dec 2015 17:08:29 +0100
Subject: [PATCH 1/3] iommu/dma: Add some missing #includes
In-Reply-To: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
References: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
Message-ID: <20151228160829.GB17673@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 05:01:46PM +0000, Robin Murphy wrote:
> Hi Joerg,
> 
> here are a couple more minor fixes for some obscure subtleties in the
> common DMA code. I see I've just missed the rc5 fixes pull, but I hope
> you can pick these up for rc6 (unless of course you're also just about
> to disappear for 2 weeks like I am).

Applied 1 and 3 to iommu/fixes, thanks.
