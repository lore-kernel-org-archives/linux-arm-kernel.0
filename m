From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 17 Aug 2016 17:41:21 +0200
Subject: [PATCH/RTF 5/7] arm64: dts: r8a7796: Add GPIO device nodes
In-Reply-To: <1471433516-4478-6-git-send-email-horms+renesas@verge.net.au>
References: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
 <1471433516-4478-6-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVDHtpuK7ZC3gf6kp=KNWTD4bXHzs=UVgTy_dsyRFRhmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 1:31 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Add GPIO device nodes to the DT of the r8a7796 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 112 +++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index faea5a960abc..2741535f8b15 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -107,6 +107,118 @@
>                         status = "disabled";
>                 };
>
> +               gpio0: gpio at e6050000 {
> +                       compatible = "renesas,gpio-r8a7796",

This compatible value should be documented in
Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt

> +                                    "renesas,gpio-rcar";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
