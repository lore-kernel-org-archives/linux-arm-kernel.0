From: phdm@macq.eu (Philippe De Muyter)
Date: Thu, 6 Sep 2018 12:36:42 +0200
Subject: [PATCH v3 1/4] dt-bindings: media: Add i.MX Pixel Pipeline binding
In-Reply-To: <20180906090215.15719-2-p.zabel@pengutronix.de>
References: <20180906090215.15719-1-p.zabel@pengutronix.de>
 <20180906090215.15719-2-p.zabel@pengutronix.de>
Message-ID: <20180906103642.GA26723@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Sep 06, 2018 at 11:02:12AM +0200, Philipp Zabel wrote:
> Add DT binding documentation for the Pixel Pipeline (PXP) found on
> various NXP i.MX SoCs.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> No changes since v2.
> ---
>  .../devicetree/bindings/media/fsl-pxp.txt     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/fsl-pxp.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/fsl-pxp.txt b/Documentation/devicetree/bindings/media/fsl-pxp.txt
> new file mode 100644
> index 000000000000..2477e7f87381
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/fsl-pxp.txt
> @@ -0,0 +1,26 @@
> +Freescale Pixel Pipeline
> +========================
> +
> +The Pixel Pipeline (PXP) is a memory-to-memory graphics processing engine
> +that supports scaling, colorspace conversion, alpha blending, rotation, and
> +pixel conversion via lookup table. Different versions are present on various
> +i.MX SoCs from i.MX23 to i.MX7.
> +
> +Required properties:
> +- compatible: should be "fsl,<soc>-pxp", where SoC can be one of imx23, imx28,
> +  imx6dl, imx6sl, imx6ul, imx6sx, imx6ull, or imx7d.

Is imx6q also compatible ?

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
