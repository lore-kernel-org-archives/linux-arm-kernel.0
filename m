From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 08 Apr 2014 15:41:29 +0200
Subject: [PATCH 0/2] ARM SMMU fixes
In-Reply-To: <2243447.NTvYmPQWSB@avalon>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2243447.NTvYmPQWSB@avalon>
Message-ID: <93132940.WGeAzvU3EP@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've obviously forgotten that Will was away for a month. CC'ing Marc Zyngier.

On Thursday 03 April 2014 01:52:55 Laurent Pinchart wrote:
> On Friday 28 February 2014 16:37:08 Laurent Pinchart wrote:
> > Hello Will,
> > 
> > I've studied your arm-smmu driver as a base to write a Renesas IOMMU
> > driver and found two small issues. Here are patches to fix them. Please
> > bear with me if my understanding was incorrect and the patches wrong :-)
> > 
> > Laurent Pinchart (2):
> >   iommu/arm-smmu: Replace list walk with platform driver data
> >   iommu/arm-smmu: Return 0 on unmap failure
> >  
> >  drivers/iommu/arm-smmu.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> Do you plan to take these patches (or at least patch 2/2) in your tree ? I
> can send a pull request to Joerg if you give me your acked-by.

Marc, would you like to handle this, or would you prefer to wait until Will 
comes back ?

-- 
Regards,

Laurent Pinchart
