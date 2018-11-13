From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 20:07:04 -0600
Subject: [PATCH V4 4/5] arm64: dts: imx: add imx8qxp mek support
In-Reply-To: <1541864596-15958-5-git-send-email-aisheng.dong@nxp.com>
References: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
 <1541864596-15958-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181113020704.GA31151@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Nov 2018 15:48:23 +0000, "A.s. Dong" wrote:
> i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> graphic and multimedia features. This patch adds imx8qxp mek board
> support.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v3->v4:
>  * remove un-documented enet phy properties
> v2->v3:
>  * Pad names update
>  * move memory node to here
>  * add no-sd and no-sdio under emmc node
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 137 ++++++++++++++++++++++++++
>  3 files changed, 142 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
