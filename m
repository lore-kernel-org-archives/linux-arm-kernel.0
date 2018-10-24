From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 24 Oct 2018 12:59:40 +0200
Subject: [PATCH V3 3/8] dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp
 compatible string
In-Reply-To: <1539886483-15775-4-git-send-email-aisheng.dong@nxp.com>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
 <1539886483-15775-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAPDyKFog=sU6DxdCD2OkEVSu0NxyUifYY2uPBE_nDi8z2xi3PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 October 2018 at 20:19, A.s. Dong <aisheng.dong@nxp.com> wrote:
> Add imx8qxp compatible string
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-serial at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-mmc at vger.kernel.org
> Cc: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +

Queued for 4.21, thanks!

Kind regards
Uffe

>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 3e29050..9201a7d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -16,6 +16,7 @@ Required properties:
>                "fsl,imx6sl-usdhc"
>                "fsl,imx6sx-usdhc"
>                "fsl,imx7d-usdhc"
> +              "fsl,imx8qxp-usdhc"
>
>  Optional properties:
>  - fsl,wp-controller : Indicate to use controller internal write protection
> --
> 2.7.4
>
