From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 24 Dec 2013 20:46:47 +0100
Subject: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
In-Reply-To: <52B9ABFF.90902@cogentembedded.com>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
 <52B9ABFF.90902@cogentembedded.com>
Message-ID: <CAMuHMdWMXAnLgkap-sQEr1z0M-nS8spwiBd_X4cGsrJq1UO6rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Dec 24, 2013 at 4:45 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +       codec: wm8978 at 0 {
>
>    Do not give chip names to device nodes, please use somewhat generic names
> instead, like "sound-codec at 0". That's to comply with ePAPR spec.

Oh, so the generic codec alias is not sufficient? Last time you gave this
comment, the code didn't contain a generic name at all, so I thought
this would be OK...

Seems like Documentation/devicetree/bindings can use some cleanups,
as it's full of examples like "codec: wm8510 at 1a"...

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
