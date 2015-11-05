From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Nov 2015 09:56:37 +0100
Subject: [PATCH v3 6/7] spi: imx: return error from dma channel request
In-Reply-To: <1446388901-6073-7-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-7-git-send-email-anton.bondarenko.sama@gmail.com>
Message-ID: <20151105085637.GJ8526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 01, 2015 at 03:41:40PM +0100, Anton Bondarenko wrote:
> From: Anton Bondarenko <anton_bondarenko@mentor.com>
> 
> On SDMA initialization return exactly the same error, which is
> reported by dma_request_slave_channel_reason(), it is a preceding
> change to defer SPI DMA initialization, if SDMA module is not yet
> available.

Maybe something like: "fix probe deferral when dmaengine is not yet
available" in the subject line will better express that this is a patch
that should be applied ASAP. Also you can move this up to the front of
the series when resending.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
