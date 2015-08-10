From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Aug 2015 15:23:54 +0200
Subject: [PATCH v3 2/2] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <10288801.ZnYt2TD47O@wasted.cogentembedded.com>
References: <2265315.MpjeDzrVz2@wasted.cogentembedded.com>
 <10288801.ZnYt2TD47O@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVj4_h8LX=XuWSyhGpSZ2BPxuWe_oJQYTRPFfYbuidm4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sun, Aug 9, 2015 at 12:09 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe GPIO[0-6] controllers in the R8A7794 device tree.
>
> Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> Changes in version 3:
> - added "power-domains" property to the GPIO device nodes.

Thanks, unwithdrawing my ack ;-)

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
