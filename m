From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jun 2018 08:14:28 +0200
Subject: [PATCH v5 0/7] add virt-dma support for imx-sdma
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180622061428.7op5ndty4hqo5cnk@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 12:56:57AM +0800, Robin Gong wrote:
> Robin Gong (6):
>   tty: serial: imx: correct dma cookie status
>   dmaengine: imx-sdma: add virt-dma support
>   dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
>     sdma_channel'
>   dmaengine: imx-sdma: remove the maximum limitation for bd numbers
>   dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
>   dmaengine: imx-sdma: alloclate bd memory from dma pool
> 
> Sascha Hauer (1):
>   dmaengine: imx-sdma: factor out a struct sdma_desc from struct
>     sdma_channel

>From my side you can get my

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

for this series, but of course it would be nice to get the feedback from
Lucas.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
