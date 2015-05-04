From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 May 2015 17:27:11 +0200
Subject: [PATCH v4 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
In-Reply-To: <1430746792-32574-1-git-send-email-stripathi@apm.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
Message-ID: <8897362.mqzfqi11lX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 May 2015 19:09:49 Suman Tripathi wrote:
> This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
> 
> v1 change:
>  * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.
> 
> v2 change:
>  * Drop the IOMMU support and switching to PIO mode for arasan.
>    controller integrated inside APM X-Gene SoC.
> 
> v3 change:
>  * Change the sdhci-of-arasan.c to support arasan4.9a.
>  * Add quirks for arasan4.9a.
> 
> v4 change:
>  * Cleanup the Documentation and dts.
> 

All three patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
