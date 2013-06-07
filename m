From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 17:25:51 +0200
Subject: [PATCH] dmaengine: at_hdmac: remove unsuded
 atc_cleanup_descriptors()
In-Reply-To: <1370618129-18049-1-git-send-email-nicolas.ferre@atmel.com>
References: <1370618129-18049-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <2095463.aoYp4tpuOZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 17:15:29 Nicolas Ferre wrote:
> Since patch 7c407d3e54dcc0c79119553c8d5ef176c1d5bc3a (DMA: AT91:
> Get residual bytes in dma buffer), the function
> atc_cleanup_descriptors() is not used anymore. We remove it to prevent
> warnings.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
