From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Apr 2013 08:30:13 +0200
Subject: [PATCH] video: imx: Add BGR666 support for parallel display
In-Reply-To: <1366585450-12762-1-git-send-email-marex@denx.de>
References: <1366585450-12762-1-git-send-email-marex@denx.de>
Message-ID: <20130422063013.GF10373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Apr 22, 2013 at 01:04:10AM +0200, Marek Vasut wrote:
> Support the BGR666 format on the IPUv3 parallel display.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/staging/imx-drm/ipu-v3/ipu-dc.c    |    9 +++++++++
>  drivers/staging/imx-drm/parallel-display.c |    2 ++

Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt is
missing in the diffstat

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
