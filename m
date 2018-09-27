From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 14:16:06 -0500
Subject: [PATCh v3 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180921125626.21971-3-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
 <20180921125626.21971-3-l.stach@pengutronix.de>
Message-ID: <20180927191606.GA7705@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Sep 2018 14:56:25 +0200, Lucas Stach wrote:
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
> v3:
> - rebase to v4.19-rc1 and already merged pinctrl driver and pending
>   clk driver
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 291 ++++++++++++++++++
>  3 files changed, 297 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
