From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 29 May 2016 11:21:38 +0200
Subject: [PATCH 05/54] MAINTAINERS: Add file patterns for rockchip device
 tree bindings
In-Reply-To: <1575416.jfSztnP7S8@phil>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-6-git-send-email-geert@linux-m68k.org>
 <1575416.jfSztnP7S8@phil>
Message-ID: <CAMuHMdVYd01kWvN5Gv_2RtPXFX2VP0nOx7Ys6=em35rk0HoOmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Sun, May 22, 2016 at 11:27 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 22. Mai 2016, 11:05:42 schrieb Geert Uytterhoeven:
>> Submitters of device tree binding documentation may forget to CC
>> the subsystem maintainer if this is missing.
>
> The "N: rockchip" line at the bottom of the block catches this nicely
> already (also just verified with a get_maintainer.pl -f call), so I don't
> think this new more explicit line is really necessary?

Oh right, thanks! I (my bashery) only looked at direct references to
Documentation/devicetree/bindings. I complely missed the rare users of "N:".

Will drop this patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
