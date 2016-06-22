From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Jun 2016 09:20:13 +0200
Subject: [PATCH] ARM: dts: r8a7794: add SMP support
In-Reply-To: <27171008.uuY7altQup@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <27171008.uuY7altQup@wasted.cogentembedded.com>
Message-ID: <CAMuHMdWcVRBxZO85_MhYVvODcbi-GYDNKfQH9LJEcrJRd=p7Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 22, 2016 at 12:03 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the device tree node for the Advanced Power Management Unit (APMU).
> Use the "enable-method" prop to  point out that the APMU should be used
> for the SMP support.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> SMP/PM basically works but you can't offline CPU0 (system hangs)...

On #renesas-soc you said it hangs on SILK only, and succeeds on Porter,
with a WARNING in the clk core (which one?) during suspend?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
