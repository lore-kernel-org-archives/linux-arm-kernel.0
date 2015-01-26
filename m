From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Jan 2015 09:56:42 +0100
Subject: [PATCH 00/14 v2] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support V2
In-Reply-To: <20150126061747.6848.9708.sendpatchset@little-apple>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
Message-ID: <CAMuHMdVLpHpn9riP5yT9ps-s4cAoYpJXcJzZNjJYoNn8Md=OMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 7:17 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support V2
>
> [PATCH 01/14 v2] ARM: shmobile: mackerel: Remove ZBOOT code
> [PATCH 02/14 v2] ARM: shmobile: mackerel: Remove Legacy C board code
> [PATCH 03/14 v2] ARM: shmobile: mackerel dts: Remove Legacy DTS file
> [PATCH 04/14 v2] ARM: shmobile: mackerel: Remove DT binding documentation
> [PATCH 05/14 v2] ARM: shmobile: mackerel: Remove mach-type entry
> [PATCH 06/14 v2] ARM: shmobile: mackerel: Remove defconfig
> [PATCH 07/14 v2] ARM: shmobile: mackerel: Remove from MAINTAINERS
> [PATCH 08/14 v2] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
> [PATCH 09/14 v2] ARM: shmobile: sh7372: Remove Legacy C SoC code
> [PATCH 10/14 v2] ARM: shmobile: sh7372: Remove DT binding documentation
> [PATCH 11/14 v2] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
> [PATCH 12/14 v2] Documentation: Remove ZBOOT MMC/SDHI utility and docs
> [PATCH 13/14 v2] pinctrl: sh-pfc: sh7372: Remove PFC support
> [PATCH 14/14 v2] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
>
> Here is my latest attempt (V2) of legacy board and SoC support removal
> for Mackerel and sh7372. Both the ARM mach-shmobile code base and the
> PINCTRL subsystem is affected.
>
> Also get rid of the remaining ZBOOT MMC/SDHI code, documentation and
> utility that has no user once sh7372 is gone.
>
> The Cortex-A8 based sh7372 SoC is rather old and never went into mass
> production anyway, so these patches that remove SoC and board support
> will only affect a few selected developers.
>
> I wish we had some way to make use of the ZBOOT MMC/SDHI code, but
> without any board or SoC code it makes little sense to keep it.
>
> Thanks to Laurent and Geert for review!
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
