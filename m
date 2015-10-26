From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 Oct 2015 10:21:40 +0800
Subject: [PATCH v2 2/3] ARM: dts: sun8i: Add Allwinner A83T dtsi
In-Reply-To: <1445557577-27383-3-git-send-email-vishnupatekar0510@gmail.com>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
 <1445557577-27383-3-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <CAGb2v65J-meF6AGR9Btjvr5DZtKoeYMi3Hj_e0-N95Z=O1vKHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 7:46 AM, Vishnu Patekar
<vishnupatekar0510@gmail.com> wrote:
> Allwinner A83T is new octa-core cortex-a7 SOC.
> This adds the basic dtsi, the clocks differs from
> earlier sun8i SOCs.
>
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 247 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 247 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-a83t.dtsi
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> new file mode 100644
> index 0000000..e85995f
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -0,0 +1,247 @@
> +               cpu at 100 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <4>;
> +               };
> +
> +               cpu at 101 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <5>;
> +               };
> +               cpu at 102 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <6>;
> +               };
> +
> +               cpu at 103 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <7>;
> +               };

The reg values are still wrong for the second cluster.

ChenYu
