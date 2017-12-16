From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 11:59:38 -0200
Subject: [PATCH 5/9] ARM: dts: imx7-colibri: specify cpu-supply
In-Reply-To: <20171206153005.6144-5-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-5-stefan@agner.ch>
Message-ID: <CAOMZO5D+wUCqweoxrMN=-GLHxrRd7Zz3vhj3qaEpc9p8gaUbSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, Dec 6, 2017 at 1:30 PM, Stefan Agner <stefan@agner.ch> wrote:
> Specify CPU supply using the "cpu-supply" property instead of
> the invalid "arm-supply" property.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index f61041af026a..6498c1136ef1 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -86,7 +86,7 @@
>  };
>
>  &cpu0 {
> -       arm-supply = <&reg_DCDC2>;
> +       cpu-supply = <&reg_DCDC2>;

Good catch. I need to apply this same fix for some other imx7 board dts:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
