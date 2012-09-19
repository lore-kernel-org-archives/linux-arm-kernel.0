From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Sep 2012 21:35:06 +0000 (UTC)
Subject: [PATCH v2 2/9] ARM: OMAP3: hwmod data: add mmu data for iva and
 isp
In-Reply-To: <1347479152-588-3-git-send-email-omar.luna@linaro.org>
References: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
 <1347479152-588-3-git-send-email-omar.luna@linaro.org>
Message-ID: <alpine.DEB.2.00.1209192134490.5264@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2012, Omar Ramirez Luna wrote:

> Add mmu hwmod data for iva and isp.
> 
> Due to compatibility an ifdef CONFIG_OMAP_IOMMU_IVA2 needs to be
> propagated (previously on iommu resource info) to hwmod data in OMAP3,
> so users of iommu and tidspbridge can avoid issues of two modules
> managing mmu data/irqs/resets; this until tidspbridge can be migrated
> to iommu framework.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Thanks, queued for 3.7.

- Paul
