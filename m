From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 29 Jul 2010 11:06:08 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729174621W.fujita.tomonori@lab.ntt.co.jp>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de> <20100729084018.GM26098@amd.com>
	<20100729174621W.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100729090607.GN26098@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 04:46:59AM -0400, FUJITA Tomonori wrote:
> On Thu, 29 Jul 2010 10:40:19 +0200
> "Roedel, Joerg" <Joerg.Roedel@amd.com> wrote:
> 
> > The IOMMU-API is not about SR-IOV.
> 
> That's true. However, the point is that include/iommu.h is far from
> the IOMMU-API.
> 
> You could still insist that include/iommu.h is designed for the
> generic IOMMU-API. But the fact is that it's designed for very
> specific purposes. No intention to make it for generic purposes.

I have no clue about the ARM iommus on the omap-platform. From a quick
look into the header file I see some similarities to the IOMMU-API. I am
also very open for discussions about how the IOMMU-API could be extended
to fit the needs of other platforms. Only because nobody has tried to
discuss about such an effort is no reason to push the IOMMU-API back.

> 
> Since you added it two years ago, nobody has tried to extend
> it. Instead, we have something like
> arch/arm/plat-omap/include/plat/iommu.h.

And I think we should try to merge this platform-specific functionality
into the IOMMU-API.

	Joerg

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
