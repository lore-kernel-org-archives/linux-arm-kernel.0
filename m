From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 18 Nov 2011 11:43:54 +0100
Subject: [PATCH 0/3] ARM: iommu: tegra: Add initial Tegra IOMMU driver
In-Reply-To: <CAHQjnOM-N9suPrv_nSRQsxGCNrf77rFLNtRcOdsjyz_O6bGdpA@mail.gmail.com>
References: <1321527667-12923-1-git-send-email-hdoyu@nvidia.com>
 <CAHQjnOM-N9suPrv_nSRQsxGCNrf77rFLNtRcOdsjyz_O6bGdpA@mail.gmail.com>
Message-ID: <20111118104354.GA19737@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 07:19:53PM +0900, KyongHo Cho wrote:

> I found that those patches are not IOMMU API implementations.
> I wonder why they need to be located in drivers/iommu?

The current effort goes into creating a generic framework for IOMMUs.
These patches create their own framework which is totally the wrong
direction, they even implement their own version of an IOMMU-API.

I object against merging them until they are converted to the generic
IOMMU-API.


        Joerg
