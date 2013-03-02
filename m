From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat,  2 Mar 2013 17:53:31 +0100
Subject: [PATCH v4 0/2] dma: imx-dma: OFTree support
Message-ID: <1362243213-29399-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patch 1 removes in v4 the allocation of imx_dma_data and simplifies
imx_dma_is_general_purpose.
Patch 2 is new and fixes the uninitialized use of imxdma->dev in
warnings.

@Arnd: I assumed your Reviewed-by tag is still okay. If it is not
please send me an email.

Regards,

Markus
