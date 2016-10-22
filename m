From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Oct 2016 15:24:10 -0200
Subject: [PATCH 1/1] arm: dts: imx6ul: 14x14-evk: add the optee node
In-Reply-To: <1477148229-6940-1-git-send-email-jason.hui.liu@nxp.com>
References: <1477148229-6940-1-git-send-email-jason.hui.liu@nxp.com>
Message-ID: <CAOMZO5C1F7tRxsF6Q8=rbG45j8UP8XJxn3W_JXoEpUa2s2w85Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Sat, Oct 22, 2016 at 12:57 PM, Jason Liu <jason.hui.liu@nxp.com> wrote:
> This patch adds the optee node for the i.MX6UL 14x14 evk board
>
> Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> index e281d50..e68dc19 100644
> --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> @@ -30,6 +30,13 @@
>                 status = "okay";
>         };
>
> +       firmware {
> +               optee {
> +                       compatible = "linaro,optee-tz";
> +                       method = "smc";

It seems we need to wait until the property lands in mainline.
