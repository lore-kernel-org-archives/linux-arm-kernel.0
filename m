From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 May 2014 14:58:57 +0200
Subject: [PATCH 2/2] ARM: shmobile: marzen dts: Remove superfluous include
In-Reply-To: <2352184.UXetcfavus@avalon>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
 <1400761997-13512-3-git-send-email-geert+renesas@glider.be>
 <2352184.UXetcfavus@avalon>
Message-ID: <CAMuHMdXWW-2BaEpMXy3b_scttgo3S1UD73kt-dH44_s-GGf4WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 2:50 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 22 May 2014 14:33:17 Geert Uytterhoeven wrote:
>> <dt-bindings/interrupt-controller/irq.h> is already included by
>> r8a7779.dtsi.
>
> Isn't it better, like with C code, to explicitly include headers that provide
> the macros you need, instead of relying on implicit #include's that could
> change later ? OK, in this specific case, it's very unlikely that r8a7779.dtsi
> would stop including <dt-bindings/interrupt-controller/irq.h>, but in the
> general case I believe explicit includes to be good practice.

You're right. I was a bit overzealous.

Simon, please drop this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
