From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 11:08:31 -0500
Subject: [PATCH V7 1/3] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <1537892878-30933-2-git-send-email-aisheng.dong@nxp.com>
References: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
 <1537892878-30933-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180927160831.GA16080@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Sep 2018 00:27:56 +0800, Dong Aisheng wrote:
> The System Controller Firmware (SCFW) is a low-level system function
> which runs on a dedicated Cortex-M core to provide power, clock, and
> resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> (QM, QP), and i.MX8QX (QXP, DX).
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v5->v6:
>  * add input clocks to clock bindings according to Rob's suggestion
>  * typo clean up
> v4->v5:
>  * scu node should be under firmware node
>  * add pd/clk/pinctrl binding as well according to Rob's suggestion
>  * switch to new generic MU binding
>    Use 8 separate mu channels in one MU instance for SCU communication
> v3->v4:
>  * fully change to mailbox binding
>  * add child node description
> v2->v3:
>  * update a bit to mailbox binding
> v1->v2:
>  * remove status
>  * changed to mu1
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 +++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
