From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 18:41:37 +0100
Subject: [GIT PULL] Automatic DMA configuration for OF-based IOMMU masters
In-Reply-To: <20141205163506.GQ1630@arm.com>
References: <20141205163506.GQ1630@arm.com>
Message-ID: <2761372.pAE6Jsk679@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 16:35:06 Will Deacon wrote:
> Hi Olof,
> 
> Please consider pulling the following series for 3.19. I appreciate that
> this is late in the day, but the patches have been around for a while and
> have collected all the Acks that they need. Marek has already been finding
> the series useful with the Exynos IOMMU, so it seems a pity to hold the
> patches up any longer.
> 

I've pulled it into a separate next/iommu-config branch in case we have
to take it out again for some reason. The autobuilder has not found any
regressions, so that's a good sign.

	Arnd
