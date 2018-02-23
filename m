From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 10:23:43 +0100
Subject: [PATCH 3/6] arm64: dts: renesas: r8a77965: Remove stale reg
 property
In-Reply-To: <1519326370-15805-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdVikGW4ZHbidVeSeBSPSDDk+1gcop_5TFsHakx9F_g_Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Remove "reg" property from cache-controller-0 device node as it does not
> have any unit address.
>
> This silences the following DTC compiler warning:
> Warning (unit_address_vs_reg): Node /cpus/cache-controller-0 has a reg
> or ranges property, but no unit name
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
