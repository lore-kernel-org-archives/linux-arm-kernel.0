From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 28 Oct 2015 01:53:34 +0100
Subject: [PATCH 1/2] arm64: Workaround renaming of __GFP_WAIT
In-Reply-To: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
Message-ID: <20151028005333.GH27420@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Fri, Oct 16, 2015 at 04:33:41PM +0100, Robin Murphy wrote:
> The imminent renaming of __GFP_WAIT in the mm tree conflicts with its
> use in the new IOMMU DMA ops; introduce a temporary local version of
> its replacement to smooth over the transition.
> 
> This patch should be reverted at 4.4-rc1.

I lost track here, are these two patches required in the iommu tree for
the next merge window?


	Joerg
