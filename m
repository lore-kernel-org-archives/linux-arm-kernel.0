From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Sep 2017 16:46:38 +0200
Subject: [PATCH 08/11] arm64: dts: renesas: r8a77970: add EtherAVB support
In-Reply-To: <20170912210535.529848695@cogentembedded.com>
References: <20170912210535.529848695@cogentembedded.com>
Message-ID: <CAMuHMdXAKhCKpCPhy3jvuexe+TEP=EueHipL_jcWu6r=0MgBsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 12, 2017 at 10:37 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A77970 part of the EtherAVB device node.
>
> Based on the original (and large) patch by Daisuke Matsushita
> <daisuke.matsushita.ns@hitachi.com>.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi

> +                       power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;

For now, you want to use "<&sysc 32>".

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
