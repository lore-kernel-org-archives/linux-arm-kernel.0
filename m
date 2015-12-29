From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 29 Dec 2015 13:14:50 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: MFD_DA9063 is boolean,
 not tristate
In-Reply-To: <1451385281-21210-1-git-send-email-thierry.reding@gmail.com>
References: <1451385281-21210-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAMuHMdUebY7F3XME0Kf97keNyYc8qe7EVJT9etpNufZdT+WJ7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Tue, Dec 29, 2015 at 11:34 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The MFD_DA9063 Kconfig symbol is a boolean, not tristate, and therefore
> m is not a valid value.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Note that the driver builds fine as a module, but I suspect that there
> was some other reason for making it boolean only.

The change to make it tristate is expected to go in through a different
tree, cfr. "[PATCH] mfd: da9063: Allow modular build"
(https://lkml.org/lkml/2015/12/7/759).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
