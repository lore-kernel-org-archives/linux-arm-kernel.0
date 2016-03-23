From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Mar 2016 18:28:09 +0800
Subject: [linux-sunxi][PATCH v3 2/8] ARM: dts :sun7i: Add SPDIF TX pin to
 the A20
In-Reply-To: <1458590466-12572-3-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
 <1458590466-12572-3-git-send-email-codekipper@gmail.com>
Message-ID: <CAGb2v64VRrM-_AAt5Xbgxc4y+-3-=mPWvuQubrHjmufUAKUA+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 4:01 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>

nit: space should be after colon, not after dts, in subject.
Same for the RX pin patch.

ChenYu

> Add the SPDIF TX pin to the A20 dtsi.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 0940a78..0c207d0 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1193,6 +1193,13 @@
>                                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>                         };
> +
> +                       spdif_tx_pins_a: spdif at 0 {
> +                               allwinner,pins = "PB13";
> +                               allwinner,function = "spdif";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +                       };
>                 };
>
>                 timer at 01c20c00 {
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
