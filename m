From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Sep 2016 13:21:49 -0300
Subject: [PATCH] ARM: imx35: add iim module to imx35.dtsi
In-Reply-To: <1473326895-19189-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1473326895-19189-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5DmaLsxAsjORCauxBkqAmOMQxu4HTASo+jxBsoo+iL8Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Sep 8, 2016 at 6:28 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> This is a prerequisite to remove the static mappings for imx35 devicetree
> based machines.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx35.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> index 490b7b44f1e7..f812d586c5ce 100644
> --- a/arch/arm/boot/dts/imx35.dtsi
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -309,6 +309,13 @@
>                                 status = "disabled";
>                         };
>
> +                       iim at 53ff0000 {
> +                               compatible = "fsl,imx35-iim";

Where is "fsl,imx35-iim" defined?
