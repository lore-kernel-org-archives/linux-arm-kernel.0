From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 31 Aug 2018 10:44:10 +0200
Subject: [PATCH] arm64: dts: renesas: r8a774a1: Add CAN nodes
In-Reply-To: <1535034166-24798-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1535034166-24798-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdUL0Ck=6er8rvx_kCSi7KR9kjBqjNRiLOL41nxeJXQG-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Thu, Aug 23, 2018 at 4:22 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> From: Chris Paterson <chris.paterson2@renesas.com>
>
> Add the device nodes for both RZ/G2M CAN channels.
>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>
> This patch depends on:
> https://lkml.org/lkml/2018/8/23/1049
> https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg30550.html
>
>
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> index 5d0109a..cd204f5 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> @@ -816,6 +816,30 @@
>                         status = "disabled";
>                 };
>
> +               can0: can at e6c30000 {
> +                       compatible = "renesas,can-r8a774a1",
> +                                    "renesas,rzg-gen2-can";

Please don't introduce "renesas,rzg-gen2-can", cfr. my comments in
https://lore.kernel.org/lkml/CAMuHMdWPuqfXOgh_-qp8q6wATU3Lj_WpX0bAOxPBX76SKvyXCQ at mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
