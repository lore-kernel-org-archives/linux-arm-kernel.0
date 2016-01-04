From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Jan 2016 09:39:17 +0100
Subject: [PATCH v2 0/3] ARM: shmobile: r8a779x: use fallback usbhs
 compatibility string
In-Reply-To: <1451856019-4222-1-git-send-email-horms+renesas@verge.net.au>
References: <1451856019-4222-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUALH_FQvOVH77V5JC3d4n7444zTh2VU-MEsOoKymFSDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 3, 2016 at 10:20 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this short series makes use of the recently added fallback usbhs
> compatibility string in the r8a779[014] device trees.
>
> Based on renesas-devel-20151228-v4.4-rc7.
>
> Changes since v1:
> * Use "renesas,rcar-gen2-usbhs" instead of "renesas,usbhs"
>
> Simon Horman (3):
>   ARM: shmobile: r8a7790: use fallback usbhs compatibility string
>   ARM: shmobile: r8a7791: use fallback usbhs compatibility string
>   ARM: shmobile: r8a7794: use fallback usbhs compatibility string

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
