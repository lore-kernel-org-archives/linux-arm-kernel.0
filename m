From: tony@atomide.com (Tony Lindgren)
Date: Tue, 2 Oct 2012 09:40:21 -0700
Subject: [PATCH v2 2/5] iommu/omap: Merge iommu2.h into iommu.h
In-Reply-To: <1349131591-10804-2-git-send-email-ido@wizery.com>
References: <20120927195526.GP4840@atomide.com>
 <1349131591-10804-1-git-send-email-ido@wizery.com>
 <1349131591-10804-2-git-send-email-ido@wizery.com>
Message-ID: <20121002164021.GS4840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ido Yariv <ido@wizery.com> [121001 15:48]:
> Since iommu is not supported on OMAP1 and will not likely to ever be
> supported, merge plat/iommu2.h into iommu.h so only one file would have
> to move to platform_data/ as part of the single zImage effort.

Thanks I'll be applying patches 2 - 5 once we have -rc1 available.

Regards,

Tony
