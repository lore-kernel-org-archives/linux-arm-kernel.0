From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:02:41 -0500
Subject: [PATCH V4 2/7] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <1498046395-30001-3-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170626180241.4453lvcsxw4b7cnp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 07:59:50PM +0800, Dong Aisheng wrote:
> i.MX 7ULP has three IOMUXC instances: IOMUXC0 for M4 ports,
> IOMUXC1 for A7 ports and IOMUXC DDR for DDR interface.
> 
> This patch adds the IOMUXC1 support for A7.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v3->v4:
>  * change pad name to IMX7ULP_PAD_X style
>  * switch to generic pinmux property
>  * input/output property are removed.
> v2->v3:
>  * switch to generic input/output-enable property
> v1->v2:
>  * add more descriptions in binding doc
>  * add missed prefix for private properties.
>  * move dt-bindings/pinctrl/imx7ulp-pinfunc.h to arch/arm/boot/dts
> ---
>  .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |  61 +++
>  arch/arm/boot/dts/imx7ulp-pinfunc.h                | 468 +++++++++++++++++++++
>  2 files changed, 529 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7ulp-pinctrl.txt
>  create mode 100644 arch/arm/boot/dts/imx7ulp-pinfunc.h

Acked-by: Rob Herring <robh@kernel.org>
