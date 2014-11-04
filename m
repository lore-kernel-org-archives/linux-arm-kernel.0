From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 3 Nov 2014 16:15:14 -0800
Subject: [PATCH v2 1/3] staging: drm/imx: parallel-display: Add 24-bit
 BGR support
In-Reply-To: <1415026488-25309-2-git-send-email-mpa@pengutronix.de>
References: <1415026488-25309-1-git-send-email-mpa@pengutronix.de>
 <1415026488-25309-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20141104001514.GA11430@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 03:54:46PM +0100, Markus Pargmann wrote:
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

Please work to get this driver out of staging instead of adding new
features to it :(
