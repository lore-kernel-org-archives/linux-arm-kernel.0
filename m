From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 Oct 2015 13:06:02 +0200
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: fix "gpio-ranges" props
In-Reply-To: <5904216.pOYUtEytKc@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <5904216.pOYUtEytKc@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVEBAJVezoj=Nm_upRSM_YjMrD8MmpX6EsT-4=vZTg+pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 1:05 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On R8A7791, GPIO banks 1 and 7  are missing  pins 26 to 31.  Correct the
> "gpio-ranges" properties of the GPIO1 node (GPIO7 is already correct).
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

LEDs and keys on r8a7791/koelsch (which are connected to a higher gpio)
still work fine.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
