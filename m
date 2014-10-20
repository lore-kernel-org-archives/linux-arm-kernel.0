From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 20 Oct 2014 10:51:17 +0800
Subject: [PATCH 1/3] staging: drm/imx: parallel-display: Add 24-bit BGR
 support
In-Reply-To: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
References: <1412625040-15662-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20141020025117.GA26642@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 09:50:38PM +0200, Markus Pargmann wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Add support for the BGR24 format to the IPUv3 parallel display.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt | 4 ++--
>  drivers/staging/imx-drm/parallel-display.c                        | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)

This doesn't apply against 3.18-rc1 :(
