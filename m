From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 14 Feb 2011 15:41:30 +0200 (EET)
Subject: [PATCH] omap iommu: print module name on error messages
In-Reply-To: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
References: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
Message-ID: <20110214.154130.1019130951550611673.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext David Cohen <dacohen@gmail.com>
Subject: [PATCH] omap iommu: print module name on error messages
Date: Sat, 12 Feb 2011 12:02:29 +0200

> OMAP IOMMU generic layer doesn't need ot print function name during
> error messages. Print module name instead which is more useful.

Agree. This makes more sense.

> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
>  arch/arm/plat-omap/iommu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
