From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Oct 2016 10:17:26 +0200
Subject: [PATCH v3 11/11] ARM: dts: sk-rzg1m: add Ether support
In-Reply-To: <1764267.cmIUehPqzi@wasted.cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <1764267.cmIUehPqzi@wasted.cogentembedded.com>
Message-ID: <CAMuHMdWizcwvThbOih=C=TqTMReCAhSkWsNNeYPp5c4k9ypkLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2016 at 11:48 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the SK-RZG1M board dependent part of the Ether device node.
> Enable DHCP and NFS root  for the kernel booting.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
