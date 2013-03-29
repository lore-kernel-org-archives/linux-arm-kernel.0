From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 29 Mar 2013 08:12:17 -0700
Subject: [PATCH v6 6/8] staging: drm/imx: Use SRC to reset IPU
In-Reply-To: <1364488523-20310-7-git-send-email-p.zabel@pengutronix.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <1364488523-20310-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130329151217.GA554@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 05:35:21PM +0100, Philipp Zabel wrote:
> Request the System Reset Controller to reset the IPU if
> specified via device tree phandle.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>  .../devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt      |  3 +++
>  drivers/staging/imx-drm/ipu-v3/ipu-common.c                  | 12 +++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
