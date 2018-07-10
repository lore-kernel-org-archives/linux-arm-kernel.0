From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Jul 2018 09:59:52 +0200
Subject: [PATCH v2 1/3] dt-bindings: freescale: Add bindings for the
 M4IF module
In-Reply-To: <1531160355-12384-1-git-send-email-festevam@gmail.com>
References: <1531160355-12384-1-git-send-email-festevam@gmail.com>
Message-ID: <1531209592.3163.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 09.07.2018, 15:19 -0300 schrieb Fabio Estevam:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Add bindings for the M4IF module present on i.MX51.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v1:
> - Newly introduced in this series (Lucas)
> 
> ?Documentation/devicetree/bindings/arm/freescale/m4if.txt | 12 ++++++++++++
> ?1 file changed, 12 insertions(+)
> ?create mode 100644 Documentation/devicetree/bindings/arm/freescale/m4if.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/m4if.txt b/Documentation/devicetree/bindings/arm/freescale/m4if.txt
> new file mode 100644
> index 0000000..93bd7b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/m4if.txt
> @@ -0,0 +1,12 @@
> +* Freescale Multi Master Multi Memory Interface (M4IF) module
> +
> +Required properties:
> +- compatible : Should be "fsl,imx51-m4if"
> +- reg : Address and length of the register set for the device
> +
> +Example:
> +
> > +m4if: m4if at 83fd8000 {
> > +	compatible = "fsl,imx51-m4if";
> > +	reg = <0x83fd8000 0x1000>;
> +};
