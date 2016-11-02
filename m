From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Nov 2016 11:26:53 +0100
Subject: [PATCH 11/12] ARM: dts: sk-rzg1e: add Ether support
In-Reply-To: <1653044.nY120UqMZW@wasted.cogentembedded.com>
References: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
 <1653044.nY120UqMZW@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUXPouB=+ZxXLxvVB+pbR=BpCR6DYOm90h2b8cDkgPkOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 12:31 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the SK-RZG1E board dependent part of the Ether device node.
> Enable DHCP and NFS root  for the kernel booting.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Subject is off-by-one (the series has only 11 patches)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
