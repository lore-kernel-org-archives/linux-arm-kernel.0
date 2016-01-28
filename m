From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 19:00:30 +0100
Subject: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
In-Reply-To: <3596300.IYfzmako0c@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <1947556.38OyJnvGS5@wuerfel>
 <20160127093018.GA21190@wfg-t540p.sh.intel.com>
 <3596300.IYfzmako0c@wuerfel>
Message-ID: <CAMuHMdWCwP8Hkn+tGEoG-FxUnjAq8uExcPhmXASh_ErU8DDN2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jan 27, 2016 at 10:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> - in some configurations, you end up without any boards selected, hitting
>   an #error in the final link

FWIW, I have a similar problem with m68k+MMU=y randconfig...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
