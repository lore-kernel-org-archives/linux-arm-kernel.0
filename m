From: codekipper@gmail.com (Code Kipper)
Date: Wed, 24 Jan 2018 13:10:58 +0100
Subject: [linux-sunxi][PATCH 4/5] arm64: allwinner: a64: Add SPDIF to the
 Pine64
In-Reply-To: <20180124103943.2062-5-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-5-codekipper@gmail.com>
Message-ID: <CAEKpxB=xB=2nJ1KjiDG=VoMT0TBdOO=rbBypWBr-o2Mag_fXew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2018 at 11:39,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
NACK.....just noticed the lack of commit message...mmmm
BR,
CK
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 604cdaedac38..70e8ff9a1f38 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -230,6 +230,13 @@
>         regulator-name = "vcc-rtc";
>  };
>
> +/* On Euler connector */
> +&spdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spdif_tx_pins_a>;
> +       status = "disabled";
> +};
> +
>  /* On Exp and Euler connectors */
>  &uart0 {
>         pinctrl-names = "default";
> --
> 2.16.0
>
