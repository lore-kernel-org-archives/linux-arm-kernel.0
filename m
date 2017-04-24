From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Apr 2017 11:03:54 +0200
Subject: [PATCH] arm64: dts: r8a7795: update PFC node name to
 pin-controller
In-Reply-To: <1493023915-21658-1-git-send-email-horms+renesas@verge.net.au>
References: <1493023915-21658-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVw9OJZarw3SRa7NuuaMtmDKPVN3Om0GFVFm5k_YAqn6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:51 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The device trees for Renesas SoCs use either pfc or pin-controller
> as the node name for the PFC device. This patch is intended to take a step
> towards unifying the node name used as pin-controller which appears to
> be more the more generic of the two and thus more in keeping with the DT

s/be more/be/

> specs.
>
> My analysis is that this is a user-visible change to the extent that kernel
> logs, and sysfs entries change from e6060000.pfc and pfc at e6060000 to
> e6060000.pin-controller and pin-controller at e6060000.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
