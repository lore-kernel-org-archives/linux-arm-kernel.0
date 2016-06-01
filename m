From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jun 2016 10:22:28 +0200
Subject: [PATCH 13/13] ARM: dts: blanche: add Ethernet support
In-Reply-To: <1669958.qjJ7i3NBPv@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1669958.qjJ7i3NBPv@wasted.cogentembedded.com>
Message-ID: <CAMuHMdU2P6VKXNpEHGOKpyuM45Pk0CuHWngxwu5AYGqYfduXXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 1, 2016 at 12:33 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts

> +       ethernet at 18000000 {
> +               compatible = "smsc,lan89218", "smsc,lan9115";

The "smsc,lan89218" needs to be documented in the device tree bindings.
Google couldn't find any evidence you submitted a patch for that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
