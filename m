From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Nov 2018 16:44:41 -0600
Subject: [PATCH v4 3/6] arm64: add support for i.MX8M EVK board
In-Reply-To: <20181114175242.12468-3-l.stach@pengutronix.de>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
 <20181114175242.12468-3-l.stach@pengutronix.de>
Message-ID: <20181116224441.GA8002@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 06:52:39PM +0100, Lucas Stach wrote:
> This is the evaluation kit board for the i.MX8M. The current level of
> support yields a working console and is able to boot userspace from
> SD card or Network.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> (v1)
> Tested-by: Tested-by: Baruch Siach <baruch@tkos.co.il> (v1)
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
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
> v4:
> - rebased to 4.10-rc1
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 290 ++++++++++++++++++
>  3 files changed, 296 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts

You missed my R-by on v3.

Rob
