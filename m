From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Dec 2015 12:32:23 +0100
Subject: [PATCH V02 0/5] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1533685.J1X7ETnh7U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 December 2015 13:22:15 Peter Ujfalusi wrote:
> 
> Changes since v1:
> - Added Reviewed-by from Andy for patch 1-2, I decided to not add the reviewed-by
>   to patch 3 due to the changes since v1
> - patch for omap-dma to support passing the filter setup to the core
> - dma_request_slave_channel_reason() remeved and it is now defines as
>   dma_request_chan()
> - Print of warning removed when DT or ACPI lookup fails and we are going to
>   Fallback to legacy lookup
> - members of struct dma_filter has been revised for simplicity.

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Looks all great to me now.
