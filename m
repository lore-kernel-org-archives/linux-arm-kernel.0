From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 28 Feb 2014 19:58:47 +0000 (UTC)
Subject: [PATCHv2 08/16] ARM: OMAP3: remove deprecated
 CONFIG_OMAP_IOMMU_IVA2
In-Reply-To: <1392315347-32967-9-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-9-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1402281958170.453@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Feb 2014, Suman Anna wrote:

> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
> usage by tidspbridge and other iommu users. The same can be achieved
> by marking the DT node disabled, so remove this obsolete flag and
> the corresponding hwmod data can be enabled.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> [s-anna at ti.com: revise commit log]
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Am assuming that someone else will be merging this as part of the entire 
series.

- Paul
