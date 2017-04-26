From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Apr 2017 13:20:52 +0200
Subject: [PATCH 0/9] ARM: dts: renesas: update PFC node name to
 pin-controller
In-Reply-To: <20170426100538.22060-1-horms+renesas@verge.net.au>
References: <20170426100538.22060-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVtMAMEjbEUA+ypwK5V+Sh+mEPs14_rUe0e4--sH=sTjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Apr 26, 2017 at 12:05 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The device trees for Renesas SoCs use either pfc or pin-controller as the
> node name for the PFC device. This patch is intended to take a step towards
> unifying the node name used as pin-controller which appears to be the more
> generic of the two and thus more in keeping with the DT specs.
>
> My analysis is that this is a user-visible change to the extent that kernel
> logs, and sysfs entries change from XXX.pfc and pfc at XXX to
> XXX.pin-controller and pin-controller at XXX.
>
> Boot tested on:
>  r8a73a4/ape6evm
>  r8a7740/armadillo800evb
>  r8a7778/bockw
>  r8a7790/lager
>  r8a7791/koelsch
>  r8a7791/porter
>  r8a7793/gose
>  sh73a9/kzm9g
>
> Not tested on (due to lack of hw access):
>  evm2/kzm9d
>  r8a7789/marzen
>
> Simon Horman (9):

For the whole series:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
