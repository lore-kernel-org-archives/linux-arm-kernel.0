From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Apr 2013 14:38:34 +0200
Subject: [PATCH 0/3] ARM: at91: move to generic DMA device tree bindings
In-Reply-To: <1366028217-5037-1-git-send-email-ludovic.desroches@atmel.com>
References: <1366028217-5037-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20130415123834.GA15139@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:16 Mon 15 Apr     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Hi,
> 
> This set of patches introduces DMA device tree bindings support for the atmel
> DMA controller and first driver conversions.
> 
> I'll send an update of dts file in the next version if there is no major issue
> with the bindings.
looks fine

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> 
> Regards
> 
> 
> Ludovic Desroches (3):
>   at_hdmac: move to generic DMA binding
>   i2c: at91: convert to dma_request_slave_channel_compat()
>   mci: at91: convert to dma_request_slave_channel_compat()
> 
>  .../devicetree/bindings/dma/atmel-dma.txt          | 26 +++++-
>  arch/arm/boot/dts/sama5d3.dtsi                     |  4 +-
>  drivers/dma/at_hdmac.c                             | 93 ++++++++++++++++++++--
>  drivers/dma/at_hdmac_regs.h                        |  4 +
>  drivers/i2c/busses/i2c-at91.c                      | 49 ++++++------
>  drivers/mmc/host/atmel-mci.c                       | 25 +++---
>  6 files changed, 154 insertions(+), 47 deletions(-)
> 
> -- 
> 1.7.11.3
> 
