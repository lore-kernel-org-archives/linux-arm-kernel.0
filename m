From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 21 Feb 2011 11:52:21 +0200 (EET)
Subject: [PATCH v3 0/2] OMAP: IOMMU fault callback support
In-Reply-To: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
Message-ID: <20110221.115221.795673505667830874.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v3 0/2] OMAP: IOMMU fault callback support
Date: Wed, 16 Feb 2011 21:35:49 +0200

> Hi,
> 
> This patch set adapts current (*isr)() to be used as fault callback.
> IOMMU faults might be very difficult to reproduce and then to figure out
> the source of the problem. Currently IOMMU driver prints not so useful
> debug message and does not notice user about such issue.
> With a fault callback, IOMMU user may debug much more useful information
> and/or react to go back to a valid state.

Tony, please put them in your queue too. Thanks.

> Br,
> 
> David
> ---
> 
> David Cohen (2):
>   OMAP2+: IOMMU: don't print fault warning on specific layer
>   OMAP: IOMMU: add support to callback during fault handling

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

> 
>  arch/arm/mach-omap2/iommu2.c            |   33 +++++++++-----------
>  arch/arm/plat-omap/include/plat/iommu.h |   14 ++++++++-
>  arch/arm/plat-omap/iommu.c              |   52 ++++++++++++++++++++++---------
>  3 files changed, 65 insertions(+), 34 deletions(-)
> 
> -- 
> 1.7.2.3
> 
