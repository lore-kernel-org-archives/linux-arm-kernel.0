From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 5 Sep 2018 19:10:36 +0200 (CEST)
Subject: [PATCH v2 1/4] dt-bindings: media: Add i.MX Pixel Pipeline binding
In-Reply-To: <20180905100018.27556-2-p.zabel@pengutronix.de>
References: <20180905100018.27556-1-p.zabel@pengutronix.de>
 <20180905100018.27556-2-p.zabel@pengutronix.de>
Message-ID: <1527575951.28748.1536167436305@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

> Philipp Zabel <p.zabel@pengutronix.de> hat am 5. September 2018 um 12:00 geschrieben:
> 
> 
> Add DT binding documentation for the Pixel Pipeline (PXP) found on
> various NXP i.MX SoCs.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
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

please correct me if i'm wrong, but the driver in patch #3 only support imx6ull so this binding is misleading. As a user i would expect that binding and driver are in sync.

Regards
Stefan
