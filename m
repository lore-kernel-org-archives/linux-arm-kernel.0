From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:09:21 -0600
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180201183126.32384-3-l.stach@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
Message-ID: <20180205041136.6kns6dfw2njnl4wz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> This is the evaluation kit board for the i.MX8M. The current level of
> support yields a working console and is able to boot userspace from
> SD card or Network.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> (v1)
> Tested-by: Tested-by: Baruch Siach <baruch@tkos.co.il> (v1)
> ---
> v2:
> - move to freescale folder
> - fix indentation
> - fix typo in Makefile
> - document compatible
> - switch to generic pinconf
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 405 ++++++++++++++++++++++++++
>  3 files changed, 411 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts

Reviewed-by: Rob Herring <robh@kernel.org>
