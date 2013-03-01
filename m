From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Mar 2013 12:57:53 -0300
Subject: [PATCH 2/2] video: imxfb: Add DT support
In-Reply-To: <1362152467-27998-3-git-send-email-mpa@pengutronix.de>
References: <1362152467-27998-1-git-send-email-mpa@pengutronix.de>
 <1362152467-27998-3-git-send-email-mpa@pengutronix.de>
Message-ID: <CAOMZO5CHsmcxjq0jSpdrjb1+DJHbVhdcWq-o4aq7TTdyTUQMwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 1, 2013 at 12:41 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Add devicetree support for imx framebuffer driver. It uses the generic
> display bindings and helper functions.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  30 ++++
>  drivers/video/imxfb.c                              | 176 +++++++++++++++++----
>  2 files changed, 173 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt
>
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> new file mode 100644
> index 0000000..fd88d26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -0,0 +1,30 @@
> +Freescale imx21 Framebuffer
> +
> +This framebuffer driver supports chips imx1 and imx21.

and mx25/mx27 as well.
