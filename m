From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Mar 2014 14:12:37 -0700
Subject: [PATCH 22/62] ARM: msm: export legacy DMA interfaces
In-Reply-To: <1395257399-359545-23-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-23-git-send-email-arnd@arndb.de>
Message-ID: <20140319211237.GC10102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:19PM +0100, Arnd Bergmann wrote:
>The msm_sdcc MMC driver and the msm_serial_hs uart driver both
>use the pre-dmaengine interfaces provided by the MSM platform.
>
>Since these drivers can be loadable modules, we should export
>the functions used in the drivers.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>Cc: David Brown <davidb@codeaurora.org>
>Cc: Daniel Walker <dwalker@fifo99.com>
>Cc: Bryan Huntsman <bryanh@codeaurora.org>
>---
> arch/arm/mach-msm/dma.c | 2 ++
> 1 file changed, 2 insertions(+)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
