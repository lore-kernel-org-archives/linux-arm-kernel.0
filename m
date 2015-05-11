From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 11 May 2015 18:46:02 +0200
Subject: [PATCH] iommu/arm-smmu: Fix sign-extension of upstream bus
 addresses at stage 1
In-Reply-To: <1431103462-8153-1-git-send-email-will.deacon@arm.com>
References: <1431103462-8153-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150511164601.GA10216@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 05:44:22PM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> I only have this one fix pending for arm-smmu, so please could you pick
> it up for 4.1? I can send a pull if you'd prefer, but it feels a bit
> OTT.
> 
> Will
> 
>  drivers/iommu/arm-smmu.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)

Applied to iommu/fixes, thanks.
