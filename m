From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 20:06:25 -0600
Subject: [PATCH V4 3/5] arm64: dts: imx: add imx8qxp support
In-Reply-To: <1541864596-15958-4-git-send-email-aisheng.dong@nxp.com>
References: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
 <1541864596-15958-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181113020625.GA29822@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Nov 2018 15:48:19 +0000, "A.s. Dong" wrote:
> i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> graphic and multimedia features. This patch adds the core SoC dtsi
> file support.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v4->v5:
>  * update to new power domain binding
>    power domain subnodes removed from dts
>  * add LPCG clock nodes
>  * clock ID updated accordingly
> v2->v3:
>  * add more SoC specific compatible string to IP nodes
>  * move memory node into board dts
>  * change pd reg value into hex
>  * add more explanation about SoC in commit message
>  * add external clocks
>  * remove pmu compatible string which is not supported
> v1->v2:
>  * mu binding usage update
>  * no define for node address
>  * do not use '_' for node name
>  * drop 'fsl-' prefix for imx dtsi
>  * no defines for unit address
>  * generic node names
>  * range map for 32bit register
>  * separate board dts
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 409 ++++++++++++++++++++++++++
>  3 files changed, 474 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> 

Reviewed-by: Rob Herring <robh@kernel.org>
